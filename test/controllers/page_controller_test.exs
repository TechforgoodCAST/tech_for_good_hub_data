defmodule TechForGoodHub.PageControllerTest do
  use TechForGoodHub.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Tech For Good"
  end
end
