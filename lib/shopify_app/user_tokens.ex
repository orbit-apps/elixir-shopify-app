defmodule ShopifyApp.UserTokens do
  use ShopifyApp.Repo, define_types: ShopifyApp.Schema.UserToken.t()

  require Ecto.Query
  require Logger

  alias ShopifyApp.Repo
  alias ShopifyApp.Schema
  alias ShopifyApp.UserTokens.Query

  @spec all() :: list(t())
  @spec all(String.t()) :: list(t())
  def all(myshopify_domain),
    do: Query.from() |> Query.where_myshopify_domain(myshopify_domain) |> Repo.all()

  def all, do: Repo.all(Query.from())

  def upsert(params) do
    %Schema.UserToken{}
    |> Schema.UserToken.changeset(params)
    |> Repo.insert(on_conflict: :replace_all, conflict_target: [:associated_user_id])
  end
end
