defmodule Rifa.Repo.Migrations.Rifaimage do
  use Ecto.Migration

  def change do
    alter table(:rifas) do
      add :img_background, :string
      add :img_reward, :string
    end
  end
end
