defmodule TestPayfyWeb.V1.ConsultDrawController do
  use TestPayfyWeb, :controller

  alias TestPayfy.Sweepstakes

  action_fallback TestPayfyWeb.FallbackController

  def show(conn, %{"id" => id}) do
    with {:ok, user} <- Sweepstakes.consult_draw(id) do
      conn
      |> render("show.json", user: user)
    end
  end
end
