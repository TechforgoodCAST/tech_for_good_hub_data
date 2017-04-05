defmodule TechForGoodHub.TagController do
  use TechForGoodHub.Web, :controller

  alias TechForGoodHub.Tag

  def index(conn, _params) do
    tags = Repo.all(Tag)
    render(conn, "index.html", tags: tags)
  end
end
