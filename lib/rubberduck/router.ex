defmodule Rubberduck.Router do
  @moduledoc """
  Router that defines which commands get sent to which aggregate.
  """

  use Commanded.Commands.Router

  # TODO: Instead of dirs for aggregates/commands/events, use actual "domain" folders?
  alias Rubberduck.Game.Aggregates.State
  alias Rubberduck.Game.Commands.IncrementState

  dispatch([IncrementState], to: State, identity: :correlation_id)
end
