defmodule ShopifyApp.Config do
  @scopes ~W{read_content write_content read_themes write_themes read_products write_products read_product_listings read_customers write_customers read_orders write_orders read_draft_orders write_draft_orders read_inventory write_inventory read_locations read_script_tags write_script_tags read_fulfillments write_fulfillments read_shipping write_shipping read_analytics read_checkouts write_checkouts read_reports  write_reports read_price_rules write_price_rules read_marketing_events write_marketing_events read_resource_feedbacks write_resource_feedbacks read_shopify_payments_payouts unauthenticated_read_product_listings unauthenticated_write_checkouts unauthenticated_write_customers unauthenticated_read_content}
  @scopes_string Enum.join(@scopes, ",")

  @shop_webhooks ~w/APP_UNINSTALLED SHOP_UPDATE/

  def app_name, do: "shopify_app"
  def app_scopes_string, do: @scopes_string

  def api_key, do: shopify_config(:api_key)
  def api_secret, do: shopify_config(:api_secret)
  def auth_redirect_uri, do: shopify_config(:auth_redirect_uri)
  def admin_api_endpoint, do: shopify_config(:admin_api_endpoint)

  @spec shop_webhooks() :: list(String.t())
  def shop_webhooks, do: @shop_webhooks

  defp shopify_config(key), do: :shopify_app |> Application.get_env(:shopify) |> Keyword.get(key)
end
