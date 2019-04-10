defmodule ShopifyApp.Repo.Migrations.CreateAuthTokens do
  use Ecto.Migration

  def change do
    create table(:auth_tokens) do
      add :app_name, :string
      add :shop_name, :string
      add :token, :string
      add :plus, :boolean, default: false, null: false

      timestamps()
    end

    create unique_index(:auth_tokens, [:shop_name])
    create unique_index(:auth_tokens, [:shop_name, :app_name])
  end
end
