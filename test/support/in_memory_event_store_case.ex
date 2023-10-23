defmodule Rubberduck.InMemoryEventStoreCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Commanded.Assertions.EventAssertions
    end
  end

  setup _tags do
    {:ok, _apps} = Application.ensure_all_started(:rubberduck)

    on_exit(fn ->
      :ok = Application.stop(:rubberduck)
    end)
  end
end