defmodule Rifa.Repo.Migrations.CreateRifas do
  use Ecto.Migration

  def change do
    create table(:rifas) do
      add :title, :string
      add :description, :string
      add :max_numbers, :integer
      add :start_at, :naive_datetime
      add :end_at, :naive_datetime

      timestamps()
    end
  end
end
