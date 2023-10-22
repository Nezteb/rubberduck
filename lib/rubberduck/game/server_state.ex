defmodule Rubberduck.Game.ServerState do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "server_states" do
    field :value, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server_state, attrs) do
    server_state
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end
end
