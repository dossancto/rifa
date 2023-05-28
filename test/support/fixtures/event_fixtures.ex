defmodule Rifa.EventFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rifa.Event` context.
  """

  @doc """
  Generate a rifa_party.
  """
  def rifa_party_fixture(attrs \\ %{}) do
    {:ok, rifa_party} =
      attrs
      |> Enum.into(%{
        description: "some description",
        end_at: ~N[2023-05-27 00:44:00],
        start_at: ~N[2023-05-27 00:44:00],
        title: "some title"
      })
      |> Rifa.Event.create_rifa_party()

    rifa_party
  end
end
