# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :shopify_app,
  ecto_repos: [ShopifyApp.Repo]

# Configures the endpoint
config :shopify_app, ShopifyAppWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: ShopifyAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ShopifyApp.PubSub,
  live_view: [signing_salt: "aSWWRBUX"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

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
  persistence: {ShopifyApp.ShopifyAPI.Initializer, :auth_token_persist, []}

config :shopify_api, ShopifyAPI.AppServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :app_init, []},
  persistence: nil

config :shopify_api, ShopifyAPI.ShopServer,
  initializer: {ShopifyApp.ShopifyAPI.Initializer, :shop_init, []},
  persistence: {ShopifyApp.ShopifyAPI.Initializer, :shop_persist, []}

# Add this to your configuration so that ShopifyAPI knows the webhook prefix.
config :shopify_api, ShopifyAPI.Webhook, uri: System.get_env("WEBHOOK_URI")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
