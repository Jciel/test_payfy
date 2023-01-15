defmodule TestPayfyWeb.V1.SweepstakeController do
  use TestPayfyWeb, :controller

  alias TestPayfy.Sweepstakes

  action_fallback(TestPayfyWeb.FallbackController)

  def create(conn, params) do
    with params <-
           Extras.Map.map_field(params, "draw_date", &DateTime.from_unix!(&1, :millisecond)),
         {:ok, sweepstake} <-
           Sweepstakes.create_sweepstake(params) do
      render(conn, "show.json", sweepstake: sweepstake)
    end
  end

  def update(conn, %{"id" => id, "attrs" => attrs}) do
    with attrs <-
           Extras.Map.map_field(attrs, "draw_date", &DateTime.from_unix!(&1, :millisecond)),
         {:ok, sweepstake} <- Sweepstakes.get_sweepstake(id),
         {:ok, updated_sweepstake} <- Sweepstakes.update_sweepstake(sweepstake, attrs) do
      conn
      |> render("show.json", sweepstake: updated_sweepstake)
    end
  end
end
