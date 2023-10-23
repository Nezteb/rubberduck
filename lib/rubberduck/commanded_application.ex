defmodule RubberDuck.CommandedApplication do
  use Commanded.Application, otp_app: :rubberduck

  router(RubberDuck.Router)

  def init(config) do
    {:ok, config}
  end
end
