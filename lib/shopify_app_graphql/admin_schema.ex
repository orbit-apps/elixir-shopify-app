defmodule ShopifyAppGraphQL.AdminSchema do
  use Absinthe.Schema
  alias ShopifyAppGraphQL.Schema

  import_types(Schema.ShopTypes)

  query do
    import_fields(:shop_admin_queries)
  end

  mutation do
  end
end
