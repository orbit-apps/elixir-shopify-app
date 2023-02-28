defmodule ShopifyAppWeb.ShopAdminController do
  use ShopifyAppWeb, :controller

  def index(conn, _params) do
    conn
    |> put_root_layout(html: false)
    |> render(:index,
      config_attrs: %{
        "data-api-key" => config(:api_key),
        "data-admin-api-endpoint" => config(:admin_api_endpoint)
      }
    )
  end

  defp config(key), do: :shopify_app |> Application.get_env(:shopify) |> Keyword.get(key)
end
