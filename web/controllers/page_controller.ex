defmodule TechForGoodHub.PageController do
  use TechForGoodHub.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
