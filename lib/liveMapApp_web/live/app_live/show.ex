defmodule LiveMapAppWeb.AppLive.Show do
  use LiveMapAppWeb, :live_view

  alias LiveMapApp.Dashboard

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:app, Dashboard.get_app!(id))}
  end

  defp page_title(:show), do: "Show App"
  defp page_title(:edit), do: "Edit App"
end
