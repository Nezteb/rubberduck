defmodule Rubberduck.Game.Events.StateIncremented do
  @derive Jason.Encoder
  defstruct [
    :amount,
    :correlation_id,
    :sent_at
  ]
end

defimpl Commanded.Serialization.JsonDecoder, for: Rubberduck.Game.Events.StateIncremented do
  @doc """
  Logic to convert string-based `sent_at` JSON value into
  an Elixir DateTime value when not nil.
  """
  def decode(%{sent_at: nil} = event) do
    %{event | sent_at: nil}
  end

  def decode(%{sent_at: sent_at} = event) do
    {:ok, datetime, _} = DateTime.from_iso8601(sent_at)
    %{event | sent_at: datetime}
  end
end
