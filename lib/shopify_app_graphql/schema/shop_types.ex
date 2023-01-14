defmodule ShopifyAppGraphQL.Schema.ShopTypes do
  use Absinthe.Schema.Notation

  alias ShopifyAppGraphQL.Resolvers

  @desc "A shop"
  object :shop do
    field :myshopify_domain, :string
  end

  object :shop_admin_queries do
    @desc "Get the Shop"
    field :shop, :shop do
      resolve(&Resolvers.Shop.shop/3)
    end
  end
end
