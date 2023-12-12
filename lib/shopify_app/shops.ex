defmodule ShopifyApp.Shops do
  @moduledoc false
  use ShopifyApp.Repo, define_types: ShopifyApp.Schema.Shop.t()
  alias ShopifyApp.Repo
  alias ShopifyApp.Schema

  def all, do: Repo.all(Schema.Shop)

  @spec insert(map()) :: ok_changeset_error()
  def insert(shop),
    do: shop |> find_or_new() |> Schema.Shop.changeset(shop) |> Repo.insert_or_update()

  @spec find(String.t()) :: t() | nil
  def find(myshopify_domain), do: Repo.get_by(Schema.Shop, myshopify_domain: myshopify_domain)

  @spec find_or_new(map()) :: t()
  def find_or_new(%{myshopify_domain: myshopify_domain}) do
    case find(myshopify_domain) do
      nil -> %Schema.Shop{}
      shop -> shop
    end
  end

  @spec delete(t()) :: ok_changeset_error()
  def delete(shop) when is_struct(shop, Schema.Shop), do: Repo.delete(shop)
end
