defmodule Rubberduck.InMemoryEventStoreCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Commanded.Assertions.EventAssertions
    end
  end

  setup tags do
    Rubberduck.InMemoryEventStoreCase.setup_in_memory_event_store(tags)
    Rubberduck.DataCase.setup_sandbox(tags)
    :ok
  end

  def setup_in_memory_event_store(_tags) do
    {:ok, _apps} = Application.ensure_all_started(:rubberduck)

    on_exit(fn ->
      :ok = Application.stop(:rubberduck)
    end)
  end
end
