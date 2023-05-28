defmodule Rifa.Event.Number do
  use Ecto.Schema
  import Ecto.Changeset

  schema "numbers" do
    field :avaible, :boolean, default: true
    field :number, :integer
    field :owner_instagram, :string
    field :rifa_numbers, :id

    timestamps()
  end

  @doc false
  def changeset(number, attrs) do
    number
    |> cast(attrs, [:number, :avaible, :rifa_numbers, :owner_instagram])
    |> validate_required([:number, :avaible, :rifa_numbers, :owner_instagram])
  end
end
