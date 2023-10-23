defmodule RubberDuck.EventHandler do
  # TODO: Eventual or strong consistency? https://hexdocs.pm/commanded/Commanded.Event.Handler.html#module-consistency
  # TODO: Concurrency? https://hexdocs.pm/commanded/Commanded.Event.Handler.html#module-concurrency
  use Commanded.Event.Handler,
    application: RubberDuck.CommandedApplication,
    name: __MODULE__,
    consistency: Application.get_env(:rubberduck, RubberDuck.CommandedApplication)[:consistency] || :eventual

  alias RubberDuck.Game.Events.StateIncremented

  # Event handlers modify non-Commanded app state (like Ecto) after events are dispatched

  def init do
    with {:ok, _pid} <- Agent.start_link(fn -> 0 end, name: __MODULE__) do
      :ok
    end
  end

  def handle(%StateIncremented{amount: amount}, _metadata) do
    Agent.update(__MODULE__, fn _ -> current_balance() + amount end)
  end

  def handle(%StateIncremented{}, _metadata) do
    # ... process the event
    :ok
  end

  def current_balance do
    Agent.get(__MODULE__, fn balance -> balance end)
  end
end
