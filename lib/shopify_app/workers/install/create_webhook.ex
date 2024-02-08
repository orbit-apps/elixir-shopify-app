defmodule ShopifyApp.Worker.Install.CreateWebhook do
  use Oban.Worker

  alias ShopifyApp.Shopify

  @impl true
  def perform(%{args: %{"myshopify_domain" => myshopify_domain, "webhook" => webhook}}) do
    {:ok, token} = ShopifyAPI.AuthTokenServer.get(myshopify_domain, ShopifyApp.Config.app_name())
    Shopify.CreateWebhook.create(token, webhook)
  end

  def enqueue(myshopify_domain, webhook),
    do: %{myshopify_domain: myshopify_domain, webhook: webhook} |> new() |> Oban.insert()
end
