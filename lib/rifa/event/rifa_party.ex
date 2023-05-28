defmodule Rifa.Event.RifaParty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rifas" do
    field :description, :string
    field :end_at, :naive_datetime
    field :start_at, :naive_datetime
    field :title, :string
    field :rifa_numbers, :id

    timestamps()
  end

  @doc false
  def changeset(rifa_party, attrs) do
    rifa_party
    |> cast(attrs, [:title, :description, :start_at, :end_at])
    |> validate_required([:title, :description, :start_at, :end_at])
  end
end
