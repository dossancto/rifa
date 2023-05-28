defmodule Rifa.Event.Number do
  use Ecto.Schema
  import Ecto.Changeset

  schema "numbers" do
    field :avaible, :boolean, default: true
    field :number, :integer
    field :owner, :id

    timestamps()
  end

  @doc false
  def changeset(number, attrs) do
    number
    |> cast(attrs, [:number, :avaible])
    |> validate_required([:number, :avaible])
  end
end
