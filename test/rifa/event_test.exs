defmodule Rifa.EventTest do
  use Rifa.DataCase

  alias Rifa.Event

  describe "rifas" do
    alias Rifa.Event.RifaParty

    import Rifa.EventFixtures

    @invalid_attrs %{description: nil, end_at: nil, start_at: nil, title: nil}

    test "list_rifas/0 returns all rifas" do
      rifa_party = rifa_party_fixture()
      assert Event.list_rifas() == [rifa_party]
    end

    test "get_rifa_party!/1 returns the rifa_party with given id" do
      rifa_party = rifa_party_fixture()
      assert Event.get_rifa_party!(rifa_party.id) == rifa_party
    end

    test "create_rifa_party/1 with valid data creates a rifa_party" do
      valid_attrs = %{description: "some description", end_at: ~N[2023-05-27 00:44:00], start_at: ~N[2023-05-27 00:44:00], title: "some title"}

      assert {:ok, %RifaParty{} = rifa_party} = Event.create_rifa_party(valid_attrs)
      assert rifa_party.description == "some description"
      assert rifa_party.end_at == ~N[2023-05-27 00:44:00]
      assert rifa_party.start_at == ~N[2023-05-27 00:44:00]
      assert rifa_party.title == "some title"
    end

    test "create_rifa_party/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Event.create_rifa_party(@invalid_attrs)
    end

    test "update_rifa_party/2 with valid data updates the rifa_party" do
      rifa_party = rifa_party_fixture()
      update_attrs = %{description: "some updated description", end_at: ~N[2023-05-28 00:44:00], start_at: ~N[2023-05-28 00:44:00], title: "some updated title"}

      assert {:ok, %RifaParty{} = rifa_party} = Event.update_rifa_party(rifa_party, update_attrs)
      assert rifa_party.description == "some updated description"
      assert rifa_party.end_at == ~N[2023-05-28 00:44:00]
      assert rifa_party.start_at == ~N[2023-05-28 00:44:00]
      assert rifa_party.title == "some updated title"
    end

    test "update_rifa_party/2 with invalid data returns error changeset" do
      rifa_party = rifa_party_fixture()
      assert {:error, %Ecto.Changeset{}} = Event.update_rifa_party(rifa_party, @invalid_attrs)
      assert rifa_party == Event.get_rifa_party!(rifa_party.id)
    end

    test "delete_rifa_party/1 deletes the rifa_party" do
      rifa_party = rifa_party_fixture()
      assert {:ok, %RifaParty{}} = Event.delete_rifa_party(rifa_party)
      assert_raise Ecto.NoResultsError, fn -> Event.get_rifa_party!(rifa_party.id) end
    end

    test "change_rifa_party/1 returns a rifa_party changeset" do
      rifa_party = rifa_party_fixture()
      assert %Ecto.Changeset{} = Event.change_rifa_party(rifa_party)
    end
  end
end
