defmodule Rifa.Repo.Migrations.UpdateRifaUserId do
  use Ecto.Migration

  def change do
    alter table(:numbers) do
      remove :owner
      add :owner_instagram, :string, null: false
    end
  end
end
