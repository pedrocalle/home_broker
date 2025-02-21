# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config
alias HomeBroker.Repo

config :home_broker,
  ecto_repos: [HomeBroker.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :home_broker, HomeBrokerWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [json: HomeBrokerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: HomeBroker.PubSub,
  live_view: [signing_salt: "WoQvAK78"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
