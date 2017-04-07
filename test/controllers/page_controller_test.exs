defmodule TechForGoodHub.PageControllerTest do
  use TechForGoodHub.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Tech For Good"
  end

  test "GET /analysis", %{conn: conn} do
    conn = get conn, "/analysis"
    assert html_response(conn, 200) =~ "Comic Relief Tech for Good"
  end
end
