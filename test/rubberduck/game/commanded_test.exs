defmodule Rubberduck.Game.CommandedTest do
  use Rubberduck.DataCase
  use Rubberduck.InMemoryEventStoreCase

  alias Rubberduck.CommandedApplication, as: App
  # alias Rubberduck.Game.Aggregates.State, as: Aggregate
  alias Rubberduck.Game.Commands.IncrementState, as: Command
  alias Rubberduck.Game.Events.StateIncremented, as: Event

  defp do_setup(context) do
    context
  end

  describe "Show" do
    setup [:do_setup]

    test "ensure any event of this type is published" do
      id = EventStore.UUID.uuid4()
      :ok = App.dispatch(%Command{id: id, amount: 4})

      assert_receive_event(
        App,
        Event,
        # predicate_fn
        fn event ->
          assert event.id === id
        end
      )
    end

    test "ensure an event is published matching the given predicate" do
      id = EventStore.UUID.uuid4()
      :ok = App.dispatch(%Command{id: id, amount: 4})

      assert_receive_event(
        App,
        Event,
        # predicate_fn
        fn event -> event.amount == 4 end,
        # assertion_fn
        fn event ->
          assert event.id === id
        end
      )
    end

    test "thing" do
      stream_uuid = EventStore.UUID.uuid4()
      expected_version = 0

      events = [%Event{amount: 10}]

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

      :ok = Commanded.EventStore.append_to_stream(App, stream_uuid, expected_version, event_data)
    end

    test "make sure two events are correlated" do
      id = EventStore.UUID.uuid4()
      :ok = App.dispatch(%Command{id: id, amount: 10})

      assert_correlated(
        App,
        Event,
        fn e -> e.id === id end,
        InitialAmountDeposited,
        fn deposited -> deposited.account_number == "ACC123" end
      )
    end
  end
end
