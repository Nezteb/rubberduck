defmodule Rubberduck.GameState do
  use GenServer

  # API

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  def apply_action(action) do
    GenServer.cast(__MODULE__, {:apply_action, action})
  end

  # Callbacks

  def init(initial_state) do
    {:ok, initial_state}
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:apply_action, action}, state) do
    # This is where you'd apply your game logic
    # assuming state is a number and action is an increment/decrement
    new_state = state + action
    {:noreply, new_state}
  end
end
