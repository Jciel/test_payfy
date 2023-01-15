defmodule TestPayfy.Repo.Migrations.CreateRegistersSweepstake do
  use Ecto.Migration

  def change do
    create table(:registers_sweepstake) do
      add :user_id, references(:users), null: false
      add :sweepstake_id, references(:sweepstakes), null: false

      timestamps()
    end

    create index(:registers_sweepstake, [:user_id])
    create index(:registers_sweepstake, [:sweepstake_id])
    create unique_index(:registers_sweepstake, [:sweepstake_id, :user_id])
  end
end
