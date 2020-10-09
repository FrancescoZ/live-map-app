defmodule LiveMapAppWeb.AppLive.Index do
  use LiveMapAppWeb, :live_view

  alias LiveMapAppWeb.AppLive.BarChart
  alias LiveMapApp.Dashboard

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Dashboard.subscribe()
    {:ok, assign(socket, :downloaded_apps, list_apps())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Dashboards")
    |> assign(:app, nil)
  end

  @doc """
  Handle the :download_added event generated from the database
  It dispatches an update to the app lists to immediately show the result
  """
  @impl true
  def handle_info({:download_added, app}, socket) do
    {:noreply, update(socket, :downloaded_apps, fn apps -> [app | apps] end)}
  end

  @doc """
  Handle the :new_marker event generated from the database module everytime a new
  download is added
  """
  @impl true
  def handle_info({:new_marker, app}, socket) do
    {:noreply,
     push_event(socket, "new_marker", %{
       marker: %{latitude: app.latitude, longitude: app.longitude, app_id: app.app_id}
     })}
  end

  defp list_apps do
    Dashboard.list_apps()
  end

  defp get_day_name(day) do
    case day do
      1 -> "Monday"
      2 -> "Tuesday"
      3 -> "Wednesday"
      4 -> "Thursday"
      5 -> "Friday"
      6 -> "Saturday"
      7 -> "Sunday"
      _ -> "Unknown"
    end
  end

  defp get_month_name(month) do
    case month do
      1 -> "Jan"
      2 -> "Feb"
      3 -> "Mar"
      4 -> "Apr"
      5 -> "May"
      6 -> "Jun"
      7 -> "Jul"
      8 -> "Aug"
      9 -> "Sep"
      10 -> "Oct"
      11 -> "Nov"
      12 -> "Dec"
      _ -> "Unknown"
    end
  end

  defp get_day_time(datetime) do
    cond do
      datetime.hour < 12 -> "Morning"
      datetime.hour < 18 -> "Afternoon"
      datetime.hour < 22 -> "Evening"
      true -> "Night"
    end
  end
end
