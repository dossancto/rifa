defmodule RifaWeb.RifaPartyController do
  use RifaWeb, :controller

  alias Rifa.Event
  alias Rifa.Event.RifaParty

  def index(conn, _params) do
    rifas = Event.list_rifas()
    render(conn, "index.html", rifas: rifas)
  end

  def new(conn, _params) do
    changeset = Event.change_rifa_party(%RifaParty{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rifa_party" => rifa_party_params}) do
    case Event.create_rifa_party(rifa_party_params) do
      {:ok, rifa_party} ->
        conn
        |> put_flash(:info, "Rifa party created successfully.")
        |> redirect(to: Routes.rifa_party_path(conn, :show, rifa_party))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rifa_party = Event.get_rifa_party!(id)
    numbers = Event.get_numbers_from_rifa(id)
    # changeset = Event.change_rifa_parjy(rifa_party)
    changeset = Event.change_number(%Event.Number{})

    conn
    |> render("show.html",
      rifa_party: rifa_party,
      numbers: numbers,
      changeset: changeset,
      action: Routes.rifa_party_path(conn, :buy_rifa)
    )
  end

  def edit(conn, %{"id" => id}) do
    rifa_party = Event.get_rifa_party!(id)
    changeset = Event.change_rifa_party(rifa_party)
    render(conn, "edit.html", rifa_party: rifa_party, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rifa_party" => rifa_party_params}) do
    rifa_party = Event.get_rifa_party!(id)

    case Event.update_rifa_party(rifa_party, rifa_party_params) do
      {:ok, rifa_party} ->
        conn
        |> put_flash(:info, "Rifa party updated successfully.")
        |> redirect(to: Routes.rifa_party_path(conn, :show, rifa_party))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rifa_party: rifa_party, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rifa_party = Event.get_rifa_party!(id)
    {:ok, _rifa_party} = Event.delete_rifa_party(rifa_party)

    conn
    |> put_flash(:info, "Rifa party deleted successfully.")
    |> redirect(to: Routes.rifa_party_path(conn, :index))
  end

  def buy_rifa(conn, %{"number" => number}) do
    user_id = conn.assigns[:current_user].id

    num =
      Map.put(number, "avaible", false)
      |> Map.put("owner", user_id)

    case Event.create_number_rifa(num) do
      {:ok, _n} ->
        conn
        |> put_flash(:info, "Rifa number submitted successfully")
        |> redirect(to: Routes.rifa_party_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "show.html",
          rifa_party: num["rifa_numbers"],
          numbers: num["number"],
          changeset: changeset,
          action: Routes.rifa_party_path(conn, :buy_rifa)
        )
    end
  end
end
