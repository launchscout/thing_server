defmodule ThingServer.PageController do
  use ThingServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
