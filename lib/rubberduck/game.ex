defmodule Rubberduck.Game do
  @moduledoc """
  The Game context.
  """

  import Ecto.Query, warn: false
  alias Rubberduck.Repo

  alias Rubberduck.Game.ServerState

  @doc """
  Returns the list of server_states.

  ## Examples

      iex> list_server_states()
      [%ServerState{}, ...]

  """
  def list_server_states do
    Repo.all(ServerState)
  end

  @doc """
  Gets a single server_state.

  Raises `Ecto.NoResultsError` if the Server state does not exist.

  ## Examples

      iex> get_server_state!(123)
      %ServerState{}

      iex> get_server_state!(456)
      ** (Ecto.NoResultsError)

  """
  def get_server_state!(id), do: Repo.get!(ServerState, id)

  @doc """
  Creates a server_state.

  ## Examples

      iex> create_server_state(%{field: value})
      {:ok, %ServerState{}}

      iex> create_server_state(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_server_state(attrs \\ %{}) do
    %ServerState{}
    |> ServerState.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a server_state.

  ## Examples

      iex> update_server_state(server_state, %{field: new_value})
      {:ok, %ServerState{}}

      iex> update_server_state(server_state, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_server_state(%ServerState{} = server_state, attrs) do
    server_state
    |> ServerState.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a server_state.

  ## Examples

      iex> delete_server_state(server_state)
      {:ok, %ServerState{}}

      iex> delete_server_state(server_state)
      {:error, %Ecto.Changeset{}}

  """
  def delete_server_state(%ServerState{} = server_state) do
    Repo.delete(server_state)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking server_state changes.

  ## Examples

      iex> change_server_state(server_state)
      %Ecto.Changeset{data: %ServerState{}}

  """
  def change_server_state(%ServerState{} = server_state, attrs \\ %{}) do
    ServerState.changeset(server_state, attrs)
  end
end
