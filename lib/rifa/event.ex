defmodule Rifa.Event do
  @moduledoc """
  The Event context.
  """

  import Ecto.Query, warn: false
  alias Rifa.Repo

  alias Rifa.Event.RifaParty
  alias Rifa.Event.Number

  @doc """
  Returns the list of rifas.

  ## Examples

      iex> list_rifas()
      [%RifaParty{}, ...]

  """
  def list_rifas do
    Repo.all(RifaParty)
  end

  def get_numbers_from_rifa(rifa_id) do
    query =
      from(n in Number,
        where: n.rifa_numbers == ^rifa_id
      )

    Repo.all(query)
  end

  @doc """
  Gets a single rifa_party.

  Raises `Ecto.NoResultsError` if the Rifa party does not exist.

  ## Examples

      iex> get_rifa_party!(123)
      %RifaParty{}

      iex> get_rifa_party!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rifa_party!(id), do: Repo.get!(RifaParty, id)

  @doc """
  Creates a rifa_party.

  ## Examples

      iex> create_rifa_party(%{field: value})
      {:ok, %RifaParty{}}

      iex> create_rifa_party(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rifa_party(attrs \\ %{}) do
    %RifaParty{}
    |> RifaParty.changeset(attrs)
    |> Repo.insert()
  end

  def create_number_rifa(attrs \\ %{}) do
    %Number{}
    |> Number.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rifa_party.

  ## Examples

      iex> update_rifa_party(rifa_party, %{field: new_value})
      {:ok, %RifaParty{}}

      iex> update_rifa_party(rifa_party, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rifa_party(%RifaParty{} = rifa_party, attrs) do
    rifa_party
    |> RifaParty.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rifa_party.

  ## Examples

      iex> delete_rifa_party(rifa_party)
      {:ok, %RifaParty{}}

      iex> delete_rifa_party(rifa_party)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rifa_party(%RifaParty{} = rifa_party) do
    delete_rifa_numbers(rifa_party.id)
    Repo.delete(rifa_party)
  end

  def delete_rifa_numbers(rifa_id) do
    query =
      from(n in Number,
        where: n.rifa_numbers == ^rifa_id
      )

    Repo.delete_all(query)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rifa_party changes.

  ## Examples

      iex> change_rifa_party(rifa_party)
      %Ecto.Changeset{data: %RifaParty{}}

  """
  def change_rifa_party(%RifaParty{} = rifa_party, attrs \\ %{}) do
    RifaParty.changeset(rifa_party, attrs)
  end

  def change_number(%Number{} = number, attrs \\ %{}) do
    Number.changeset(number, attrs)
  end
end
