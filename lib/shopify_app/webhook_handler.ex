defmodule ShopifyApp.WebhookHandler do
  @doc """
  The Shopify Webhook Handler
  """

  require Logger

  def handle_webhook(app, shop, domain, payload) do
    Logger.debug(
      "incoming webhook #{inspect(app)} #{inspect(shop)} #{inspect(domain)} #{inspect(payload)}"
    )
  end
end
