defmodule TestPayfy.Sweepstakes do
  import Ecto.Query, warn: false
  alias Extras.Result
  alias TestPayfy.Repo
  alias TestPayfy.Sweepstakes.Sweepstake
  alias TestPayfy.Users.User
  alias Extras.Result

  @spec get_sweepstake(binary) :: {:ok, %Sweepstake{}} | {:error, :not_found}

  def get_sweepstake(id) do
    Sweepstake
    |> TestPayfy.Repo.get(id)
    |> Result.from_maybe(:not_found)
  end

  @spec create_sweepstake(map()) :: {:ok, %Sweepstake{}} | {:error, %Ecto.Changeset{}}

  def create_sweepstake(attrs) do
    %Sweepstake{}
    |> Sweepstake.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_sweepstake(%Sweepstake{}, map()) ::
          {:ok, %Sweepstake{}} | {:error, %Ecto.Changeset{}}

  def update_sweepstake(%Sweepstake{} = sweepstake, attrs) do
    sweepstake
    |> Sweepstake.changeset(attrs)
    |> Repo.update()
  end

  @spec consult_draw(binary) :: {:ok, %User{}} | Result.t()

  def consult_draw(sweepstake_id) do
    Sweepstake
    |> preload(:user)
    |> TestPayfy.Repo.get(sweepstake_id)
    |> then(fn sweepstake ->
      case sweepstake do
        nil ->
          Extras.Result.fail(%{sweepstake_id: ["does not exist"]})

        sweepstake ->
          sweepstake.user
          |> Extras.Result.from_maybe(%{user_id: ["does not exist"]})
      end
    end)
  end
end
