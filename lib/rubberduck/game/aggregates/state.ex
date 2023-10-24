defmodule Rubberduck.Game.Aggregates.State do
  defstruct [
    :amount,
    :id,
    :sent_at
  ]

  alias Commanded.Aggregate.Multi
  alias Rubberduck.Game.Commands.IncrementState
  alias Rubberduck.Game.Events.MessageSent
  alias Rubberduck.Game.Events.StateIncremented

  # "handle the command, protect its business invariants, and return a domain event when successfully handled"

  # Public command API

  # Take an aggregate, a command, return an event
  def execute(%__MODULE__{}, %IncrementState{amount: n}) when n in [nil, 0] do
    nil
  end

  def execute(%__MODULE__{amount: n} = state, %IncrementState{id: id, amount: increment_amount})
      when n in [nil, 0] do
    state
    |> Multi.new()
    |> Multi.execute(fn %__MODULE__{} ->
      %StateIncremented{id: id, amount: increment_amount}
    end)
    |> Multi.execute(fn %__MODULE__{} ->
      # This is just a test of multi-event commands
      %MessageSent{id: id, message: "Hello world"}
    end)
  end

  def execute(%__MODULE__{amount: before_amount} = state, %IncrementState{
        id: id,
        amount: increment_amount
      }) do
    state
    |> Multi.new()
    |> Multi.execute(fn %__MODULE__{} ->
      %StateIncremented{id: id, amount: before_amount + increment_amount}
    end)
    |> Multi.execute(fn %__MODULE__{} ->
      # This is just a test of multi-event commands
      %MessageSent{id: id, message: "Hello world"}
    end)
  end

  # State mutators

  # Take an aggregate, an event, return updated aggregate
  def apply(%__MODULE__{amount: n}, %StateIncremented{id: id, amount: increment_amount})
      when n in [nil, 0] do
    %__MODULE__{id: id, amount: increment_amount}
  end

  def apply(%__MODULE__{amount: before_amount}, %StateIncremented{
        id: id,
        amount: increment_amount
      }) do
    %__MODULE__{id: id, amount: before_amount + increment_amount}
  end

  def apply(%__MODULE__{} = state, %MessageSent{message: _message}) do
    state
  end

  # Private helpers
end
