defmodule ShopifyApp.Plug.DevProxy do
  if Mix.env() == :dev do
    require Logger
    defdelegate init(opts), to: ReverseProxyPlug

    def call(%{request_path: "/manifest.json"} = conn, opts),
      do: ReverseProxyPlug.call(conn, opts)

    def call(%{request_path: "/static/js/bundle.js"} = conn, opts),
      do: ReverseProxyPlug.call(conn, opts)

    def call(%{request_path: "/shop_admin" <> _} = conn, opts),
      do: ReverseProxyPlug.call(conn, opts)

    def call(conn, _), do: conn
  else
    def init(_), do: raise("This is for dev only")
    def call(_, _), do: raise("This is for dev only")
  end
end
