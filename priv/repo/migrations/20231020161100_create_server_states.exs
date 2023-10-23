defmodule RubberDuck.Repo.Migrations.CreateServerStates do
  use Ecto.Migration

  def change do
    create table(:server_states, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :value, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
