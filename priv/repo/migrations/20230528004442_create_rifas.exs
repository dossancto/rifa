defmodule Rifa.Repo.Migrations.CreateRifas do
  use Ecto.Migration

  def change do
    create table(:rifas) do
      add :title, :string
      add :description, :string
      add :start_at, :naive_datetime
      add :end_at, :naive_datetime
      add :rifa_numbers, references(:numbers, on_delete: :nothing)

      timestamps()
    end

    create index(:rifas, [:rifa_numbers])
  end
end
