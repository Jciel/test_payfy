defmodule TestPayfy.RegistersSweepstake.RegisterSweepstake do
  use TestPayfy.Schema
  import Ecto.Changeset

  schema "registers_sweepstake" do
    belongs_to :user, TestPayfy.Users.User
    belongs_to :sweepstake, TestPayfy.Sweepstakes.Sweepstake

    timestamps()
  end

  def changeset(register_sweepstake, attrs) do
    register_sweepstake
    |> cast(attrs, [
      :user_id,
      :sweepstake_id
    ])
    |> validate_required([:user_id, :sweepstake_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:sweepstake_id)
    |> unique_constraint([:sweepstake_id, :user_id],
      message: "User already registered in this draw"
    )
  end
end
