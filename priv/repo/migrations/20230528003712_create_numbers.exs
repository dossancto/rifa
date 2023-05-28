defmodule Rifa.Repo.Migrations.CreateNumbers do
  use Ecto.Migration

  def change do
    create table(:numbers) do
      add :number, :integer, null: false
      add :avaible, :boolean, default: true, null: false
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:numbers, [:owner])
  end
end
