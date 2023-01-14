defmodule ShopifyApp.Factory do
  use ExMachina.Ecto, repo: ShopifyApp.Repo

  alias ShopifyApp.Schema

  def shopify_gid(type), do: sequence(type, &"gid://shopify/#{type}/#{&1}")
  def myshopify_domain, do: Faker.Internet.domain_name()

  def shop_factory do
    %Schema.Shop{myshopify_domain: myshopify_domain()}
  end
end
