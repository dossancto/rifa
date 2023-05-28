defmodule Rifa.Repo.Migrations.ChangeRifaNumbers do
  use Ecto.Migration

  def change do
    alter table(:numbers) do
      add :rifa_numbers, references(:rifas, on_delete: :nothing) 
    end

    create index(:numbers, [:rifa_numbers])
  end
end
