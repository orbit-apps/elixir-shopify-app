defmodule ShopifyApp.Shops do
  @moduledoc false
  alias ShopifyApp.Repo
  alias ShopifyApp.Schema

  def all, do: Repo.all(Schema.Shop)

  def insert(shop) do
    shop
    |> find_or_new()
    |> Schema.Shop.changeset(shop)
    |> Repo.insert_or_update()
  end

  @spec find(String.t()) :: %Schema.Shop{} | nil
  def find(myshopify_domain), do: Repo.get_by(Schema.Shop, myshopify_domain: myshopify_domain)

  @spec find_or_new(map()) :: %Schema.Shop{}
  def find_or_new(%{myshopify_domain: myshopify_domain}) do
    case find(myshopify_domain) do
      nil -> %Schema.Shop{}
      shop -> shop
    end
  end
end
