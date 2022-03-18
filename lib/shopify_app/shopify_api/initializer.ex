defmodule ShopifyApp.ShopifyAPI.Initializer do
  @moduledoc false
  require Logger

  def app_init do
    [
      %ShopifyAPI.App{
        name: "shopify_app",
        client_id: System.get_env("API_KEY"),
        client_secret: System.get_env("API_SECRET"),
        auth_redirect_uri: "",
        nonce: "test",
        scope:
          "read_content,write_content,read_themes,write_themes,read_products,write_products,read_product_listings,read_customers,write_customers,read_orders,write_orders,read_draft_orders,write_draft_orders,read_inventory,write_inventory,read_locations,read_script_tags,write_script_tags,read_fulfillments,write_fulfillments,read_shipping,write_shipping,read_analytics,read_checkouts,write_checkouts,read_reports, write_reports,read_price_rules,write_price_rules,read_marketing_events,write_marketing_events,read_resource_feedbacks,write_resource_feedbacks,read_shopify_payments_payouts,unauthenticated_read_product_listings,unauthenticated_write_checkouts,unauthenticated_write_customers,unauthenticated_read_content"
      }
    ]
  end

  def shop_init, do: Enum.map(ShopifyApp.Shop.all(), &to_shopify_shop_struct/1)

  def shop_persist(_key, %ShopifyAPI.Shop{} = shop) do
    shop
    |> Map.from_struct()
    |> ShopifyApp.Shop.insert()
  end

  def auth_token_init, do: Enum.map(ShopifyApp.AuthToken.all(), &to_shopify_token_struct/1)

  def auth_token_persist(_key, %ShopifyAPI.AuthToken{} = token) do
    token
    |> Map.from_struct()
    |> ShopifyApp.AuthToken.insert()
  end

  defp to_shopify_shop_struct(%{domain: domain}), do: %ShopifyAPI.Shop{domain: domain}

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
