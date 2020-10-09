defmodule LiveMapAppWeb.AppLive.BarChart do
  use Phoenix.LiveComponent

  @default %{
    id: nil,
    title: "Dashboard",
    list: [],
    total: 0,
    percentage: false
  }

  @doc """
  Renders a BarChart live_component .
    id: the id used from the components,
    title: Title showed on top of the graph,
    list: a list of structure which contains the category
      name and the number of them, each element is a bar in
      the graph
    total: the total number element analysed ,
    percentage: if true it calculate the percentage of
      elements in each group,
  ## Examples

      <%= live_component @socket, LiveMapAppWeb.AppLive.BarChart,
        id: :new,
        title: "Title to show"
        list: [{"category", 1},{"categor2", 2}]
        total: 3
        percentage: false

  """
  def render(assigns) do
    ~L"""
    <dl class="dashboard" data-category="<%= @id %>">
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
