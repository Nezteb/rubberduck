defmodule Rubberduck.CommandedApplication do
  use Commanded.Application, otp_app: :rubberduck

  router(Rubberduck.Router)

  def init(config) do
    {:ok, config}
  end
end
