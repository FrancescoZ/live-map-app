defmodule LiveMapAppWeb.AppLive.Index do
  use LiveMapAppWeb, :live_view

  alias LiveMapApp.Dashboard.App
  alias LiveMapAppWeb.AppLive.Dashboard

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: LiveMapApp.Dashboard.subscribe()
    {:ok, assign(socket, :downloaded_apps, list_apps())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit App")
    |> assign(:app, LiveMapApp.Dashboard.get_app!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New App")
    |> assign(:app, %App{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Apps")
    |> assign(:app, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    app = LiveMapApp.Dashboard.get_app!(id)
    {:ok, _} = LiveMapApp.Dashboard.delete_app(app)

    {:noreply, assign(socket, :apps, list_apps())}
  end

  @impl true
  def handle_info({:download_added, app}, socket) do
    {:noreply, update(socket, :downloaded_apps, fn apps -> [app| apps] end)}
  end

  def handle_info({:new_marker, app}, socket) do
    {:noreply, push_event(socket, "new_marker", %{
      marker: %{latitude: app.latitude, longitude: app.longitude, app_id: app.app_id}
    })}
  end

  defp list_apps do
    LiveMapApp.Dashboard.list_apps()
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
end
