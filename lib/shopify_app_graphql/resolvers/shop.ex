defmodule ShopifyAppGraphQL.Resolvers.Shop do
  alias ShopifyApp.Shops

  def shop(_parent, _args, %{context: context}) do
    {:ok, Shops.find(context.shop.domain)}
  end
end
