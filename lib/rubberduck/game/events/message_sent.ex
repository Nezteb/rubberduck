defmodule Rubberduck.Game.Events.MessageSent do
  @derive Jason.Encoder
  defstruct [
    :id,
    :message
  ]
end
