defmodule LiveMapApp.Repo do
  use Ecto.Repo,
    otp_app: :live_map_app,
    adapter: Ecto.Adapters.Postgres
end
