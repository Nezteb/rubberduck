defmodule Rubberduck.CommandedApplication do
  use Commanded.Application, otp_app: :rubberduck

  router(RubberduckWeb.Router)

  def init(config) do
    {:ok, config}
  end
end
