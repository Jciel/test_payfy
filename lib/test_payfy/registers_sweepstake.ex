defmodule TestPayfy.RegistersSweepstake do
  import Ecto.Query, warn: false
  alias Extras.Result
  alias TestPayfy.Repo
  alias TestPayfy.RegistersSweepstake.RegisterSweepstake
  alias Extras.Result

  @spec get_register_sweepstake(binary) :: {:ok, %RegisterSweepstake{}} | {:error, :not_found}

  def get_register_sweepstake(id) do
    RegisterSweepstake
    |> TestPayfy.Repo.get(id)
    |> Result.from_maybe(%{register_sweepstake_id: ["does not exist"]})
  end

  @spec create_register_sweepstake(map()) ::
          {:ok, %RegisterSweepstake{}} | {:error, %Ecto.Changeset{}} | Result.t()

  def create_register_sweepstake(attrs) do
    with {:ok, sweepstake} <- TestPayfy.Sweepstakes.get_sweepstake(attrs.sweepstake_id) do
      if :gt == DateTime.compare(sweepstake.draw_date, DateTime.now!("Etc/UTC")) do
        %RegisterSweepstake{}
        |> RegisterSweepstake.changeset(attrs)
        |> Repo.insert()
      else
        Extras.Result.fail(%{sweepstake_id: ["Registration outside the draw deadline"]})
      end
    end
  end
end
