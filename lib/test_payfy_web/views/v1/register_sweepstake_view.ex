defmodule TestPayfyWeb.V1.RegisterSweepstakeView do
  use TestPayfyWeb, :view

  def render("show.json", %{register_sweepstake: _register_sweepstake}) do
    %{
      data: "Ok"
    }
  end
end
