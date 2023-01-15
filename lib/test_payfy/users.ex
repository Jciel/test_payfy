defmodule TestPayfy.Users do
  import Ecto.Query, warn: false

  alias Extras.Result
  alias TestPayfy.Repo
  alias TestPayfy.Users.User
  alias Extras.Result

  @spec get_user(binary) :: {:ok, %User{}} | {:error, :not_found}

  def get_user(id) do
    User
    |> TestPayfy.Repo.get(id)
    |> Result.from_maybe(%{user_id: ["does not exist"]})
  end

  @spec create_user(map()) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}

  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
