defmodule Rubberduck.Game.Aggregates.State do
  defstruct [
    :amount,
    :id,
    :sent_at
  ]

  alias Rubberduck.Game.Commands.IncrementState
  alias Rubberduck.Game.Events.StateIncremented

  # "handle the command, protect its business invariants, and return a domain event when successfully handled"

  # Public command API

  # Take an aggregate, a command, return an event
  def execute(%__MODULE__{}, %IncrementState{amount: n}) when n in [nil, 0] do
    nil
  end

  def execute(%__MODULE__{amount: n}, %IncrementState{amount: increment_amount})
      when n in [nil, 0] do
    %StateIncremented{amount: increment_amount}
  end

  def execute(%__MODULE__{amount: before_amount}, %IncrementState{amount: increment_amount}) do
    %StateIncremented{amount: before_amount + increment_amount}
  end

  # State mutators

  # Take an aggregate, an event, return updated aggregate
  def apply(%__MODULE__{amount: n}, %StateIncremented{amount: increment_amount})
      when n in [nil, 0] do
    %__MODULE__{amount: increment_amount}
  end

  def apply(%__MODULE__{amount: before_amount}, %StateIncremented{amount: increment_amount}) do
    %__MODULE__{amount: before_amount + increment_amount}
  end
end
