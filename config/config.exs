# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tech_for_good_hub_data,
  namespace: TechForGoodHub,
  ecto_repos: [TechForGoodHub.Repo]

# Configures the endpoint
config :tech_for_good_hub_data, TechForGoodHub.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "4Us1MG3ZHK2tx2ZW/5nYWoU9bHWV6Zpx90lwwrtnQHgGtZzDJBL2uRUWNXDj1NU8",
  render_errors: [view: TechForGoodHub.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TechForGoodHub.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
