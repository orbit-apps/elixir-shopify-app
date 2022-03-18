defmodule ShopifyApp.AuthToken do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset
  alias ShopifyApp.Repo

  schema "auth_tokens" do
    field :app_name, :string
    field :plus, :boolean, default: false
    field :shop_name, :string
    field :token, :string

    timestamps()
  end

  def all, do: Repo.all(__MODULE__)

  def insert(token) do
    token
    |> find_or_new()
    |> changeset(token)
    |> Repo.insert_or_update()
  end

  @doc false
  def changeset(auth_token, attrs) do
    auth_token
    |> cast(attrs, [:app_name, :shop_name, :token, :plus])
    |> validate_required([:app_name, :shop_name, :token, :plus])
  end

  @doc false
  defp find_or_new(%{shop_name: shop_name, app_name: app_name}) do
    case Repo.get_by(__MODULE__, shop_name: shop_name, app_name: app_name) do
      nil -> %__MODULE__{}
      auth_token -> auth_token
    end
  end
end
