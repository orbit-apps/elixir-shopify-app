defmodule ShopifyApp.Plug.DevProxy do
  if Mix.env() == :dev do
    require Logger
    import Plug.Conn, only: [halt: 1], warn: false
    defdelegate init(opts), to: ReverseProxyPlug

    def call(%{request_path: "/manifest.json"} = conn, opts),
      do: conn |> ReverseProxyPlug.call(opts) |> halt()

    def call(%{request_path: "/static/js/bundle.js"} = conn, opts),
      do: conn |> ReverseProxyPlug.call(opts) |> halt()

    def call(%{request_path: "/shop_admin" <> _} = conn, opts) do
      opts =
        Keyword.put(opts, :error_callback, fn error ->
          Logger.error("Network error: #{inspect(error)}")
        end)

      conn
      |> ReverseProxyPlug.call(opts)
      |> halt()
    end

    def call(conn, _), do: conn
  else
    def init(_), do: raise("This is for dev only")
    def call(_, _), do: raise("This is for dev only")
  end
end
