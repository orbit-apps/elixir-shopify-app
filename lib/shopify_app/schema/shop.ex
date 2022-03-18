defmodule ShopifyApp.Schema.Shop do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :domain, :string

    timestamps()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:domain])
    |> validate_required([:domain])
  end
end
