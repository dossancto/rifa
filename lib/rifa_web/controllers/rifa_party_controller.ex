defmodule RifaWeb.RifaPartyController do
  use RifaWeb, :controller

  alias Rifa.Accounts
  alias Rifa.Event
  alias Rifa.Event.RifaParty

  def index(conn, _params) do
    rifas = Event.list_rifas()
    {:ok, current_datetime} = DateTime.now("Etc/UTC")

    render(conn, "index.html", rifas: rifas, current_datetime: current_datetime)
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

    {:ok, current_datetime} = DateTime.now("Etc/UTC")

    conn
    |> render("show.html",
      rifa_party: rifa_party,
      numbers: numbers,
      changeset: changeset,
      current_datetime: current_datetime,
      action: Routes.rifa_party_path(conn, :buy_rifa)
    )
  end

  def show_admin(conn, %{"id" => id}) do
    rifa_party = Event.get_rifa_party!(id)
    numbers = Event.get_numbers_from_rifa(id)
    # changeset = Event.change_rifa_parjy(rifa_party)
    changeset = Event.change_number(%Event.Number{})

    {:ok, current_datetime} = DateTime.now("Etc/UTC")

    conn
    |> render("show_admin.html",
      rifa_party: rifa_party,
      numbers: numbers,
      changeset: changeset,
      current_datetime: current_datetime,
      action: Routes.rifa_party_path(conn, :buy_rifa)
    )
  end

  def view_admin(conn, _params) do
    changeset = Accounts.change_user_registration(%Accounts.User{})
    users = Accounts.get_all_users()
    # IO.puts users

    conn
    |> render("view_admin.html",
      users: users,
      changeset: changeset
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
    num =
      Map.put(number, "avaible", false)
      |> Map.put("owner", number["owner_instagram"])

    rifa_id = num["rifa_numbers"]

    case Event.create_number_rifa(num) do
      {:ok, _n} ->
        conn
        |> redirect(to: Routes.rifa_party_path(conn, :show, rifa_id))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "show.html",
          rifa_party: Event.get_rifa_party!(rifa_id),
          numbers: Event.get_numbers_from_rifa(rifa_id),
          changeset: changeset,
          action: Routes.rifa_party_path(conn, :buy_rifa)
        )
    end
  end

  def buy_a_number(conn, %{"id" => id}) do
    changeset = Event.change_number(%Event.Number{})
    rifa_party = Event.get_rifa_party!(id)
    numbers = Event.get_numbers_from_rifa(id)

    render(conn, "buy_a_number.html",
      changeset: changeset,
      rifa_party: rifa_party,
      numbers: numbers,
      action: Routes.rifa_party_path(conn, :buy_rifa)
    )
  end

  def remove_number(conn, %{"id" => id}) do
    rifa_party = Event.get_rifa_party!(id)
    numbers = Event.get_numbers_from_rifa(id)
    # changeset = Event.change_rifa_parjy(rifa_party)
    changeset = Event.change_number(%Event.Number{})

    {:ok, current_datetime} = DateTime.now("Etc/UTC")

    conn
    |> render("remove_number.html",
      rifa_party: rifa_party,
      numbers: numbers,
      changeset: changeset,
      current_datetime: current_datetime,
      action: Routes.rifa_party_path(conn, :buy_rifa)
    )
  end

  def delete_number(conn, %{"id" => id, "number" => number}) do
    rifa_party = Event.get_rifa_party!(id)
    {:ok, _rifa_party} = Event.remove_bought_number(id, number)

    conn
    |> redirect(to: Routes.rifa_party_path(conn, :show, rifa_party))
  end

  defp get_number_infos(numbers, max_num) do
    sold = Enum.count(numbers)

    porcentage =
      (sold * 100 / max_num)
      |> :erlang.float_to_binary(decimals: 2)

    %{
      sold: sold,
      avaible: max_num - sold,
      porcentage: porcentage
    }
  end

  def number_stats(conn, %{"id" => id}) do
    rifa_party = Event.get_rifa_party!(id)
    numbers = Event.get_numbers_from_rifa(id)
    changeset = Event.change_number(%Event.Number{})

    {_, grouped_numbers} =
      numbers
      |> Enum.group_by(& &1.owner_instagram)
      |> Enum.reverse()
      |> Enum.unzip()

    {:ok, current_datetime} = DateTime.now("Etc/UTC")

    num_infos = get_number_infos(numbers, rifa_party.max_numbers)

    conn
    |> render("number_stats.html",
      rifa_party: rifa_party,
      numbers: grouped_numbers,
      changeset: changeset,
      current_datetime: current_datetime,
      infos: num_infos,
      action: Routes.rifa_party_path(conn, :buy_rifa)
    )
  end

  def sorteio(conn, %{"id" => id}) do
    numbers = Event.get_numbers_from_rifa(id)

    number =
      numbers
      |> Enum.random()

    conn
    |> json(%{number: number.number, owner: number.owner_instagram})
  end
end
