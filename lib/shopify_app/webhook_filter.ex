defmodule ShopifyApp.WebhookFilter do
  @moduledoc false
  require Logger

  def process(%ShopifyAPI.EventPipe.Event{action: "orders/create", object: %{}} = event) do
    Logger.info("orders/create #{inspect(event)}", label: :event)
  end

  def process(%ShopifyAPI.EventPipe.Event{action: action} = event) do
    Logger.info("Unknown action: #{action} called with #{inspect(event)}", label: :event)
  end
end
