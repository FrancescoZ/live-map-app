defmodule LiveMapApp.Repo do
  use Ecto.Repo,
    otp_app: :liveMapApp,
    adapter: Ecto.Adapters.Postgres
end
