defmodule TechForGoodHub.ProposalControllerTest do
  use TechForGoodHub.ConnCase

  alias TechForGoodHub.Proposal
  alias TechForGoodHub.Organisation

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, proposal_path(conn, :index)
    assert html_response(conn, 200) =~ "Projects"
  end

  test "shows chosen resource", %{conn: conn} do
    organisation = Repo.insert! %Organisation{}
    proposal = Repo.insert! %Proposal{organisation_id: organisation.id}
    proposal = Repo.get!(Proposal, proposal.id)
               |> Repo.preload([:organisation, :tags])
    conn = get conn, proposal_path(conn, :show, proposal)
    assert html_response(conn, 200) =~ "Proposal from"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, proposal_path(conn, :show, -1)
    end
  end
end
