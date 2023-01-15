defmodule TestPayfy.Repo.Migrations.CreateSweepstakes do
  use Ecto.Migration

  def change do
    create table(:sweepstakes) do
      add :name, :string, null: false
      add :draw_date, :utc_datetime, null: false

      add :user_id, references(:users), null: true

      timestamps()
    end

    create index(:sweepstakes, [:user_id])
  end
end
