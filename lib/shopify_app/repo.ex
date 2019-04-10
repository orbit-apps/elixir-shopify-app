defmodule ShopifyApp.Repo do
  use Ecto.Repo,
    otp_app: :shopify_app,
    adapter: Ecto.Adapters.Postgres
end
