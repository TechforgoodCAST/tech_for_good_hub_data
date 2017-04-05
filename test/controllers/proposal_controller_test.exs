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
    assert html_response(conn, 200) =~ "Show proposal"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, proposal_path(conn, :show, -1)
    end
  end
end
