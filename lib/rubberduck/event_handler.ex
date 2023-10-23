defmodule Rubberduck.EventHandler do
  # TODO: Eventual or strong consistency? https://hexdocs.pm/commanded/Commanded.Event.Handler.html#module-consistency
  # TODO: Concurrency? https://hexdocs.pm/commanded/Commanded.Event.Handler.html#module-concurrency
  use Commanded.Event.Handler,
    application: Rubberduck.CommandedApplication,
    name: __MODULE__,
    consistency:
      Application.get_env(:rubberduck, Rubberduck.CommandedApplication)[:consistency] || :eventual

  alias Rubberduck.Game.Events.StateIncremented

  # Event handlers modify non-Commanded app state (like Ecto) after events are dispatched

  def init do
    with {:ok, _pid} <- Agent.start_link(fn -> 0 end, name: __MODULE__) do
      :ok
    end
  end

  def handle(%StateIncremented{amount: n}, _metadata) when n in [nil, 0] do
    :ok
  end

  def handle(%StateIncremented{amount: increment_amount}, _metadata) do
    Agent.update(__MODULE__, fn current_balance -> current_balance + increment_amount end)
  end

  def handle(%StateIncremented{}, _metadata) do
    # ... process the event
    :ok
  end

  def current_balance do
    Agent.get(__MODULE__, fn balance -> balance end)
  end

  def before_reset do
    IO.puts("Resetting #{__MODULE__}")
    :ok
  end
end
