defmodule LiveMapAppWeb.AppLive.Dashboard do
  use Phoenix.LiveComponent

  @default %{
    id: nil,
    title: "Dashboard",
    list: [],
    total: 0,
    percentage: false
  }

  def render(assigns) do
    ~L"""
    <dl>
      <dt><%= @title %></dt>
      <%= for {countryName, count} <- @list do %>
        <dd class="percentage percentage-<%= trunc((count/@total)*100) %>">
          <span class="text">
            <%= countryName %>: <%= if @percentage do Float.round((count/@total)*100,2) else count end %>
          </span>
        </dd>
      <% end %>
    </dl>
    """
  end

  def mount(_assigns, socket) do
    {:ok, socket}
  end

  def update(assigns, socket) do
    {:ok, assign(socket, Map.merge(@default, assigns))}
  end
end
