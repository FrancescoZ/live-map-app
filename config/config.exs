# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :liveMapApp,
  ecto_repos: [LiveMapApp.Repo]

# Configures the endpoint
config :liveMapApp, LiveMapAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AaTdv5ShEI3zjVyztSilpgJOgjwfWsAAJEoMGooHM8fHVbCPGkkuQ13BV1htIuqu",
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