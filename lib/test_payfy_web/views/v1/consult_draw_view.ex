defmodule TestPayfyWeb.V1.ConsultDrawView do
  use TestPayfyWeb, :view

  def render("show.json", %{user: user}) do
    %{
      data: %{
        id: user.id,
        name: user.name,
        email: user.email
      }
    }
  end
end
