defmodule Rubberduck.Game.Commands.IncrementState do
  # use Ecto.Schema
  # import Ecto.Changeset

  # @type t :: %__MODULE__{}

  defstruct [:id, :amount, :sent_at]

  # TODO: Eventually persist these with Ecto? Or does Commmanded/EventStore already do that?

  # embedded_schema do
  #   field :amount, :integer
  #   # set by client, we don't validate
  #   field :correlation_id, :string
  #   field :sent_at, :string
  # end

  # @cast_fields [
  #   :amount,
  #   :correlation_id,
  #   :sent_at
  # ]

  # # TODO: Copied this, probably can remove and make simple Ecto boilerplate
  # def new(new_attrs) do
  #   case apply_action(changeset(%__MODULE__{}, new_attrs), :validate) do
  #     {:ok, command} -> {:ok, command}
  #     {:error, changeset} -> {:error, changeset}
  #   end
  # end

  # defp changeset(state, attrs) do
  #   state |> cast(attrs, @cast_fields)
  # end
end
