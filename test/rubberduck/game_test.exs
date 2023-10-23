defmodule Rubberduck.GameTest do
  use Rubberduck.DataCase

  alias Rubberduck.Game

  describe "server_states" do
    alias Rubberduck.Game.ServerState

    import Rubberduck.GameFixtures

    @invalid_attrs %{value: nil}

    test "list_server_states/0 returns all server_states" do
      server_state = server_state_fixture()
      assert Game.list_server_states() == [server_state]
    end

    test "get_server_state!/1 returns the server_state with given id" do
      server_state = server_state_fixture()
      assert Game.get_server_state!(server_state.id) == server_state
    end

    test "create_server_state/1 with valid data creates a server_state" do
      valid_attrs = %{value: 42}

      assert {:ok, %ServerState{} = server_state} = Game.create_server_state(valid_attrs)
      assert server_state.value == 42
    end

    test "create_server_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Game.create_server_state(@invalid_attrs)
    end

    test "update_server_state/2 with valid data updates the server_state" do
      server_state = server_state_fixture()
      update_attrs = %{value: 43}

      assert {:ok, %ServerState{} = server_state} =
               Game.update_server_state(server_state, update_attrs)

      assert server_state.value == 43
    end

    test "update_server_state/2 with invalid data returns error changeset" do
      server_state = server_state_fixture()
      assert {:error, %Ecto.Changeset{}} = Game.update_server_state(server_state, @invalid_attrs)
      assert server_state == Game.get_server_state!(server_state.id)
    end

    test "delete_server_state/1 deletes the server_state" do
      server_state = server_state_fixture()
      assert {:ok, %ServerState{}} = Game.delete_server_state(server_state)
      assert_raise Ecto.NoResultsError, fn -> Game.get_server_state!(server_state.id) end
    end

    test "change_server_state/1 returns a server_state changeset" do
      server_state = server_state_fixture()
      assert %Ecto.Changeset{} = Game.change_server_state(server_state)
    end
  end
end
