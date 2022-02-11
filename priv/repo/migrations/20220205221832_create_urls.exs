defmodule Stordly.Repo.Migrations.CreateUrls do
  use Ecto.Migration

  def change do
    create table(:urls) do
      add :hash, :string
      add :url, :string

      timestamps()
    end

    create unique_index(:urls, [:url])
    create unique_index(:urls, [:hash])
  end
end
