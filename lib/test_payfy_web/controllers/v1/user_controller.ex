defmodule TestPayfyWeb.V1.UserController do
  use TestPayfyWeb, :controller

  alias TestPayfy.Users

  action_fallback TestPayfyWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Users.create_user(params) do
      render(conn, "show.json", user: user)
    end
  end
end
