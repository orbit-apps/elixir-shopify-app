defmodule ShopifyApp.Shop do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias ShopifyApp.Repo

  schema "shops" do
    field :domain, :string

    timestamps()
  end

  def all, do: Repo.all(__MODULE__)

  def insert(shop) do
    shop
    |> find_or_new()
    |> changeset(shop)
    |> Repo.insert_or_update()
  end

  @doc false
  def changeset(shop, attrs) do
    shop
    |> cast(attrs, [:domain])
    |> validate_required([:domain])
  end

  @doc false
  defp find_or_new(%{domain: domain}) do
    case Repo.get_by(__MODULE__, domain: domain) do
      nil -> %__MODULE__{}
      shop -> shop
    end
  end
end
