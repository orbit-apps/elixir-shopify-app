defmodule ShopifyApp.AuthToken do
  @moduledoc false
  alias ShopifyApp.Repo
  alias ShopifyApp.Schema

  def all, do: Repo.all(Schema.AuthToken)

  def insert(token) do
    token
    |> find_or_new()
    |> Schema.AuthToken.changeset(token)
    |> Repo.insert_or_update()
  end

  def find_or_new(%{shop_name: shop_name, app_name: app_name}) do
    case Repo.get_by(Schema.AuthToken, shop_name: shop_name, app_name: app_name) do
      nil -> %Schema.AuthToken{}
      auth_token -> auth_token
    end
  end
end
