defmodule Rubberduck.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rubberduck.Game` context.
  """

  @doc """
  Generate a server_state.
  """
  def server_state_fixture(attrs \\ %{}) do
    {:ok, server_state} =
      attrs
      |> Enum.into(%{
        value: 42
      })
      |> Rubberduck.Game.create_server_state()

    server_state
  end
end
