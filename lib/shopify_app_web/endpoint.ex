defmodule ShopifyAppWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :shopify_app

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_shopify_app_key",
    signing_salt: "ijq1g2Yt",
    same_site: "Lax"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :shopify_app,
    gzip: false,
    only: ShopifyAppWeb.static_paths()

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
    plug Phoenix.Ecto.CheckRepoStatus, otp_app: :shopify_app
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  # Shopify Webhook handler, needs to be before the Jason parser!
  plug ShopifyAPI.Plugs.Webhook,
    app_name: "shopify_app",
    prefix: "/shopify/webhook",
    callback: {ShopifyApp.WebhookHandler, :handle_webhook, []}

  if Mix.env() == :dev do
    plug ShopifyApp.Plug.DevProxy, upstream: "http://localhost:3000"
  end

  plug ShopifyAdminProxy,
    upstream: "https://example.myshopify.com/admin/api/2022-04/graphql.json",
    mount_path: "/api/admin/shopify_graphql_proxy"

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug ShopifyAppWeb.Router
end
