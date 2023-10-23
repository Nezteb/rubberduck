defmodule RubberDuck.EventStore do
  use EventStore,
    otp_app: :rubberduck,
    serializer: Commanded.Serialization.JsonSerializer
end
