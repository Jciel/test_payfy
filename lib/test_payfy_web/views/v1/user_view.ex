defmodule TestPayfyWeb.V1.UserView do
  use TestPayfyWeb, :view

  def render("show.json", %{user: user}) do
    %{
      data: %{
        id: user.id
      }
    }
  end
end
