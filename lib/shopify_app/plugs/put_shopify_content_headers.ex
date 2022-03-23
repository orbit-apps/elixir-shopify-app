defmodule ShopifyApp.Plugs.PutShopifyContentHeaders do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _options) do
    conn
    |> put_resp_header("x-frame-options", "ALLOW-FROM https://" <> myshopify_domain(conn))
    |> put_resp_header(
      "content-security-policy",
      "frame-ancestors https://" <> myshopify_domain(conn) <> " https://admin.shopify.com;"
    )
  end

  defp myshopify_domain(%{assigns: %{shop: %{domain: domain}}}), do: domain
end
