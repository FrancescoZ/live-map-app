defmodule LiveMapAppWeb.Router do
  use LiveMapAppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LiveMapAppWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveMapAppWeb do
    post "/add_downaload", DownloadAppController, :add_download
    pipe_through :browser

    live "/", AppLive.Index, :index
    live "/apps", AppLive.Index, :index
    live "/apps/new", AppLive.Index, :new
    live "/apps/:id/edit", AppLive.Index, :edit

    live "/apps/:id", AppLive.Show, :show
    live "/apps/:id/show/edit", AppLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LiveMapAppWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: LiveMapAppWeb.Telemetry

    end
  end
end
