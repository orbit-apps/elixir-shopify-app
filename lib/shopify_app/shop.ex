defmodule ShopifyApp.Shop do
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

  def find_or_new(%{domain: domain}) do
    case Repo.get_by(Schema.Shop, domain: domain) do
      nil -> %Schema.Shop{}
      shop -> shop
    end
  end
end
