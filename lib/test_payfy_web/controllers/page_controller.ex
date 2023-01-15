defmodule TestPayfyWeb.PageController do
  use TestPayfyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
