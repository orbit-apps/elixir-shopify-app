defmodule ShopifyApp.Repo.Migrations.CreateShops do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :domain, :string

      timestamps()
    end

    create unique_index(:shops, [:domain])
  end
end
