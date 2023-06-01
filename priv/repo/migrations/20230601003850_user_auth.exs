defmodule Rifa.Repo.Migrations.UserAuth do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :is_adm, :boolean, null: false, default: false
    end

  end
end
