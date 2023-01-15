defmodule TestPayfyWeb.V1.RegisterSweepstakeController do
  use TestPayfyWeb, :controller

  alias TestPayfy.RegistersSweepstake

  action_fallback(TestPayfyWeb.FallbackController)

  def create(conn, params) do
    params = %{
      user_id: params["user_id"],
      sweepstake_id: params["sweepstake_id"]
    }

    with {:ok, register_sweepstake} <- RegistersSweepstake.create_register_sweepstake(params) do
      render(conn, "show.json", register_sweepstake: register_sweepstake)
      # else
      #   {:error, :not_found} ->
      #     conn
      #     |> put_status(:unprocessable_entity)
      #     |> json(%{
      #       "errors" => %{
      #         "sweepstake_id" => [
      #           "does not exist"
      #         ]
      #       }
      #     })

      #   {:error, %Ecto.Changeset{} = changeset} ->
      #     conn
      #     |> put_status(:unprocessable_entity)
      #     |> put_view(TestPayfyWeb.ChangesetView)
      #     |> render("error.json", changeset: changeset)

      #   {:error, error} ->
      #     conn
      #     |> put_status(:unprocessable_entity)
      #     |> json(%{errors: error})
    end
  end
end
