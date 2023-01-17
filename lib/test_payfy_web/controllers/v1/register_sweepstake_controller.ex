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
    end
  end
end
