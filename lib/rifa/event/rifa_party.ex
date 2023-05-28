defmodule Rifa.Event.RifaParty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rifas" do
    field :description, :string
    field :end_at, :naive_datetime
    field :max_numbers, :integer
    field :start_at, :naive_datetime
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(rifa_party, attrs) do
    rifa_party
    |> cast(attrs, [:title, :description, :start_at, :end_at, :max_numbers])
    |> validate_required([:title, :description, :start_at, :end_at])
  end
end
