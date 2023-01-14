defmodule ShopifyApp.ShopifyAPI.Initializer do
  @moduledoc false
  require Logger

  def app_init do
    [
      %ShopifyAPI.App{
        name: ShopifyApp.Config.app_name(),
        client_id: ShopifyApp.Config.api_key(),
        client_secret: ShopifyApp.Config.api_secret(),
        auth_redirect_uri: ShopifyApp.Config.auth_redirect_uri(),
        nonce: "test",
        scope: ShopifyApp.Config.app_scopes_string()
      }
    ]
  end

  def shop_init, do: Enum.map(ShopifyApp.Shops.all(), &to_shopify_shop_struct/1)

  def shop_persist(%ShopifyAPI.AuthToken{shop_name: myshopify_domain}),
    do: ShopifyApp.Shops.insert(%{myshopify_domain: myshopify_domain})

  def shop_persist(_key, %ShopifyAPI.Shop{domain: myshopify_domain}),
    do: ShopifyApp.Shops.insert(%{myshopify_domain: myshopify_domain})

  def auth_token_init, do: Enum.map(ShopifyApp.AuthTokens.all(), &to_shopify_token_struct/1)

  def auth_token_persist(_key, %ShopifyAPI.AuthToken{} = token) do
    token
    |> Map.from_struct()
    |> ShopifyApp.AuthTokens.insert()
  end

  defp to_shopify_shop_struct(%{myshopify_domain: domain}), do: %ShopifyAPI.Shop{domain: domain}

  defp to_shopify_token_struct(%{app_name: app_name, shop_name: shop_name, token: token}) do
    %ShopifyAPI.AuthToken{
      app_name: app_name,
      shop_name: shop_name,
      token: token,
      timestamp: 0,
      plus: false
    }
  end
end
