# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :live_map_app,
  ecto_repos: [LiveMapApp.Repo],
  api_token: System.get_env("API_TOKEN")

# Configures the endpoint
config :live_map_app, LiveMapAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("PHOENIX_SECRET"),
  render_errors: [view: LiveMapAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LiveMapApp.PubSub,
  live_view: [signing_salt: "ifCTTFiF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
