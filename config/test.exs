import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :rubberduck, Rubberduck.Repo,
  hostname: "localhost",
  username: "postgres",
  password: "postgres",
  database: "rubberduck_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rubberduck, RubberduckWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "bsoa9u6sxfR6zo5UYMi6t5nUjV9UxuQEc11LdVUyk9hzAu9a5zVlQS6ZFW3W7Nts",
  server: false

config :rubberduck, Rubberduck.CommandedApplication,
  event_store: [
    adapter: Commanded.EventStore.Adapters.InMemory,
    serializer: Commanded.Serialization.JsonSerializer
  ],
  # TODO: Why strong?
  consistency: :strong

# In test we don't send emails.
config :rubberduck, Rubberduck.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
