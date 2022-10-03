defmodule ShopifyAppWeb.ShopAdminController do
  use ShopifyAppWeb, :controller

  require Logger

  def index(conn, params) do
    Logger.debug(inspect(params))
    Logger.debug(inspect(conn.req_headers))
    Logger.debug(inspect(conn.assigns))

    conn
    |> put_root_layout(false)
    |> render("index.html",
      config_attrs: %{
        "data-api-key" => config(:api_key),
        "data-admin-api-endpoint" => config(:admin_api_endpoint)
      }
    )
  end

  defp config(key), do: :shopify_app |> Application.get_env(:shopify) |> Keyword.get(key)
end
