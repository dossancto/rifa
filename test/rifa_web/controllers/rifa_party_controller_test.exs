defmodule RifaWeb.RifaPartyControllerTest do
  use RifaWeb.ConnCase

  import Rifa.EventFixtures

  @create_attrs %{description: "some description", end_at: ~N[2023-05-27 00:44:00], start_at: ~N[2023-05-27 00:44:00], title: "some title"}
  @update_attrs %{description: "some updated description", end_at: ~N[2023-05-28 00:44:00], start_at: ~N[2023-05-28 00:44:00], title: "some updated title"}
  @invalid_attrs %{description: nil, end_at: nil, start_at: nil, title: nil}

  describe "index" do
    test "lists all rifas", %{conn: conn} do
      conn = get(conn, Routes.rifa_party_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Rifas"
    end
  end

  describe "new rifa_party" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.rifa_party_path(conn, :new))
      assert html_response(conn, 200) =~ "New Rifa party"
    end
  end

  describe "create rifa_party" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rifa_party_path(conn, :create), rifa_party: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.rifa_party_path(conn, :show, id)

      conn = get(conn, Routes.rifa_party_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Rifa party"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rifa_party_path(conn, :create), rifa_party: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Rifa party"
    end
  end

  describe "edit rifa_party" do
    setup [:create_rifa_party]

    test "renders form for editing chosen rifa_party", %{conn: conn, rifa_party: rifa_party} do
      conn = get(conn, Routes.rifa_party_path(conn, :edit, rifa_party))
      assert html_response(conn, 200) =~ "Edit Rifa party"
    end
  end

  describe "update rifa_party" do
    setup [:create_rifa_party]

    test "redirects when data is valid", %{conn: conn, rifa_party: rifa_party} do
      conn = put(conn, Routes.rifa_party_path(conn, :update, rifa_party), rifa_party: @update_attrs)
      assert redirected_to(conn) == Routes.rifa_party_path(conn, :show, rifa_party)

      conn = get(conn, Routes.rifa_party_path(conn, :show, rifa_party))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, rifa_party: rifa_party} do
      conn = put(conn, Routes.rifa_party_path(conn, :update, rifa_party), rifa_party: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Rifa party"
    end
  end

  describe "delete rifa_party" do
    setup [:create_rifa_party]

    test "deletes chosen rifa_party", %{conn: conn, rifa_party: rifa_party} do
      conn = delete(conn, Routes.rifa_party_path(conn, :delete, rifa_party))
      assert redirected_to(conn) == Routes.rifa_party_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.rifa_party_path(conn, :show, rifa_party))
      end
    end
  end

  defp create_rifa_party(_) do
    rifa_party = rifa_party_fixture()
    %{rifa_party: rifa_party}
  end
end
