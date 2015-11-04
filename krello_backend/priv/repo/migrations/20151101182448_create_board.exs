defmodule KrelloBackend.Repo.Migrations.CreateBoard do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :title, :string
      add :description, :string

      timestamps
    end

  end
end
