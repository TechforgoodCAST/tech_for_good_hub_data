defmodule TechForGoodHub.ProposalControllerTest do
  use TechForGoodHub.ConnCase

  alias TechForGoodHub.Proposal

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, proposal_path(conn, :index)
    assert html_response(conn, 200) =~ "Projects"
  end

  test "shows chosen resource", %{conn: conn} do
    proposal = Repo.insert! %Proposal{}
    conn = get conn, proposal_path(conn, :show, proposal)
    assert html_response(conn, 200) =~ "Proposal from"
  end

  test "shows entries in a category", %{conn: conn} do
    ["approach-type", "focus", "target-audience", "tech-type"]
    |> Enum.each(fn(category) ->
      conn = get conn, proposal_path(conn, :category, category)
      assert html_response(conn, 200) =~ "category"
    end)
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, proposal_path(conn, :show, -1)
    end
  end
end
