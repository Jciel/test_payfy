defmodule TestPayfy.Sweepstakes.Sweepstake do
  use TestPayfy.Schema
  import Ecto.Changeset

  schema "sweepstakes" do
    field :name, :string
    field :draw_date, :utc_datetime

    belongs_to :user, TestPayfy.Users.User

    timestamps()
  end

  def changeset(sweepstake, attrs) do
    sweepstake
    |> cast(attrs, [
      :name,
      :draw_date,
      :user_id
    ])
    |> validate_required([:name, :draw_date])
    |> foreign_key_constraint(:user_id)
  end
end
