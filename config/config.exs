# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :shopify_app,
  ecto_repos: [ShopifyApp.Repo]

# Configures the endpoint
config :shopify_app, ShopifyAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "BaCSN0TeeSORCKa4sfDKXFiA+x68+09JDKQKctDU7UFqDvg3uYS5WEYbyOPG5p28",
  render_errors: [view: ShopifyAppWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ShopifyApp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

###################
# ShopifyAPI Config
###################
config :shopify_api, ShopifyAPI.AuthTokenServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :auth_token_init, []},
  persistance: {ShopifyApp.ShopifyAPI.Initializer, :auth_token_persist, []}

config :shopify_api, ShopifyAPI.AppServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :app_init, []},
  persistance: nil

config :shopify_api, ShopifyAPI.ShopServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :shop_init, []},
  persistance: {ShopifyApp.ShopifyAPI.Initializer, :shop_persist, []}

config :shopify_api,
  webhook_filter: {ShopifyApp.WebhookFilter, :process, []},
  json_library: Jason

config :shopify_api, ShopifyAPI.Webhook, uri: System.get_env("WEBHOOK_URI")

config :exq,
  start_on_application: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
