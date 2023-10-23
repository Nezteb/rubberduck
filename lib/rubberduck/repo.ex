defmodule RubberDuck.Repo do
  use Ecto.Repo,
    otp_app: :rubberduck,
    adapter: Ecto.Adapters.Postgres
end
