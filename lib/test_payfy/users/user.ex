defmodule TestPayfy.Users.User do
  use TestPayfy.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :name,
      :email
    ])
    |> validate_format(:email, ~r/@/)
    |> validate_required([:name, :email])
  end
end
