defmodule ShopifyApp.Shopify.CreateWebhook do
  use ShopifyApp.GraphQLLoader, dir: "gql"
  require Logger

  @type response() :: {:ok, map() | :already_created} | {:error, :create_webhook}

  @error_addr_already_taken "Address for this topic has already been taken"
  @gql load_query_file("webhook_create.graphql")

  @spec create(ShopifyAPI.AuthToken.t(), String.t()) :: response()
  def create(token, topic) do
    callback_url = ShopifyAppWeb.Router.webhooks_url()

    case ShopifyAPI.GraphQL.query(token, @gql, %{topic: topic, callback_url: callback_url}) do
      {:ok,
       %{
         response: %{
           "webhookSubscriptionCreate" => %{
             "userErrors" => [%{"message" => @error_addr_already_taken}]
           }
         }
       }} ->
        {:ok, :already_created}

      {:ok, %{response: %{"webhookSubscriptionCreate" => %{"webhook" => webhook}}}} ->
        {:ok, webhook}

      {:ok,
       %{response: %{"webhookSubscriptionCreate" => %{"userErrors" => user_errors = [_ | _]}}}} ->
        Logger.error("create webhook received user errors: #{inspect(user_errors)}")

        {:error, :create_webhook}

      {:error, error} ->
        Logger.error("create webhook received an unknown error: #{inspect(error)}")

        {:error, :create_webhook}
    end
  end
end
