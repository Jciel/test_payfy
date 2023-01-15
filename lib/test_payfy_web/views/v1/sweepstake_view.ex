defmodule TestPayfyWeb.V1.SweepstakeView do
  use TestPayfyWeb, :view

  def render("show.json", %{sweepstake: sweepstake}) do
    %{
      data: %{
        id: sweepstake.id
      }
    }
  end
end
