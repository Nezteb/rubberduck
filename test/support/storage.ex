defmodule Rubberduck.Storage do
  @doc """
  Clear the event store and read store databases
  """
  def reset! do
    reset_eventstore()
    reset_readstore()
  end

  defp reset_eventstore do
    config = Rubberduck.EventStore.config()

    {:ok, conn} = Postgrex.start_link(config)

    EventStore.Storage.Initializer.reset!(conn, config)
  end

  defp reset_readstore do
    config = Application.get_env(:my_app, MyApp.Repo)

    {:ok, conn} = Postgrex.start_link(config)

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  # TODO: Use actual table names (and maybe figure out how to not have to manually update this like the docs imply...)
  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      table1,
      table2,
      table3
    RESTART IDENTITY
    CASCADE;
    """
  end
end
