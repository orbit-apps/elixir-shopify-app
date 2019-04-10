defmodule ShopifyApp.WebhookFilter do
  def process(%ShopifyAPI.EventPipe.Event{action: "orders/create", object: %{}} = event) do
    IO.inspect("orders/create #{inspect(event)}", label: :event)
  end

  def process(%ShopifyAPI.EventPipe.Event{action: action} = event) do
    IO.inspect("Unknown action: #{action} called with #{inspect(event)}", label: :event)
  end
end
