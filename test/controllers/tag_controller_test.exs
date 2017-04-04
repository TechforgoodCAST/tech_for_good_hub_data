defmodule TechForGoodHub.TagControllerTest do
  use TechForGoodHub.ConnCase

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tag_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tags"
  end
end
