defmodule Rubberduck.Game.CommandedTest do
  use Rubberduck.DataCase 

  alias Commanded.Aggregate.Multi
  alias Rubberduck.CommandedApplication
  alias Rubberduck.EventHandler
  alias Rubberduck.Game.Aggregates.State
  alias Rubberduck.Game.Commands.IncrementState
  alias Rubberduck.Game.Events.StateIncremented
  alias Rubberduck.Game.Events.MessageSent

  defp do_setup(context) do
    context
  end

  describe "commanded event store" do
    setup [:do_setup]

    test "basic event check" do
      stream_uuid = EventStore.UUID.uuid4()
      expected_version = 0

      events = [%StateIncremented{amount: 10}]

      event_data =
        Enum.map(events, fn event ->
          %Commanded.EventStore.EventData{
            causation_id: EventStore.UUID.uuid4(),
            correlation_id: EventStore.UUID.uuid4(),
            event_type: Commanded.EventStore.TypeProvider.to_string(event),
            data: event,
            metadata: %{}
          }
        end)

      :ok = Commanded.EventStore.append_to_stream(CommandedApplication, stream_uuid, expected_version, event_data)
    end

    test "business logic without event store" do
      id = EventStore.UUID.uuid4()

      starter_state = %State{id: id, amount: 10}
      command = %IncrementState{id: id, amount: 20}
      expected_events = [%StateIncremented{id: id, amount: 30}, %MessageSent{id: id, message: "Hello world"}]

      # Test the aggregate execution
      {aggregate, actual_events} = State.execute(starter_state, command) |> Multi.run()
      assert %State{amount: 40, id: ^id} = aggregate
      assert actual_events === expected_events

      # Test the event handler
      start_balance = EventHandler.current_balance()
      Enum.map(actual_events, fn event ->
        EventHandler.handle(event, %{})
      end)
      assert EventHandler.current_balance() - start_balance === 30
    end
  end
end
