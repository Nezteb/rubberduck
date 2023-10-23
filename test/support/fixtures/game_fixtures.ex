defmodule RubberDuck.GameFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `RubberDuck.Game` context.
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
      |> RubberDuck.Game.create_server_state()

    server_state
  end
end
