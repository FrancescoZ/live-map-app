defmodule LiveMapAppWeb.DownloadAppController do
  use LiveMapAppWeb, :controller
  alias LiveMapApp.Dashboard

  @unknown "Unknown"

  def add_download(conn, %{
        "longitude" => long,
        "latitude" => lat,
        "downloaded_at" => download_time,
        "app_id" => app_name
      }) do
    with {:ok, date, _} <- DateTime.from_iso8601(download_time),
         {longitude, ""} <- Float.parse(long),
         {latitude, ""} <- Float.parse(lat),
         country <-
           Tesla.get("https://maps.googleapis.com/maps/api/geocode/json",
             query: [
               latlng: "#{latitude},#{longitude}",
               key: Application.get_env(:live_map_app, :api_token)
             ]
           )
           |> handle_tesla_response() do
      case Dashboard.create_app(%{
             latitude: lat,
             longitude: long,
             app_id: app_name,
             download_at: date,
             country: country
           }) do
        {:ok, _result} ->
          conn
          |> put_status(:created)
          |> json(:created)

        {:error, error} ->
          conn
          |> put_status(500)
          |> json(inspect(error))
      end
    else
      _ ->
        conn
        |> put_status(400)
        |> json(:invalid_paramters)
    end
  end

  def add_download(conn, _params) do
    conn
    |> put_status(400)
    |> json(:invalid_json_body)
  end

  defp handle_tesla_response({:ok, %Tesla.Env{status: 200, body: body}}),
    do:
      body
      |> Jason.decode()
      |> parse_results()

  defp handle_tesla_response(_response), do: @unknown

  defp parse_results({:ok, %{"results"=> nil}}), do: @unknown
  defp parse_results({:ok, %{"results"=> result}}), do: result
      |> List.first()
      |> parse_address()
  defp parse_results(_), do: @unknown

  defp parse_address(nil), do: @unknown
  defp parse_address(components),
    do:
      components
      |> Map.get("address_components")
      |> Enum.reduce("", fn %{"types" => types, "long_name" => name}, acc ->
        if Enum.member?(types, "country") do
          acc <> name
        else
          acc
        end
      end)
end
