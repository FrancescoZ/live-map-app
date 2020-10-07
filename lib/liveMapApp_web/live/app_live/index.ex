defmodule LiveMapAppWeb.AppLive.Index do
  use LiveMapAppWeb, :live_view

  alias LiveMapApp.Dashboard
  alias LiveMapApp.Dashboard.App

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :apps, list_apps())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit App")
    |> assign(:app, Dashboard.get_app!(id))
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
    app = Dashboard.get_app!(id)
    {:ok, _} = Dashboard.delete_app(app)

    {:noreply, assign(socket, :apps, list_apps())}
  end

  defp list_apps do
    Dashboard.list_apps()
  end
end
