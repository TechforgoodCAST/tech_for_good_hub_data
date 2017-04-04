defmodule TechForGoodHub.ProposalControllerTest do
  use TechForGoodHub.ConnCase

  alias TechForGoodHub.Proposal
  @valid_attrs %{amount_applied: 42, development_stage: "some content", graphic_url: "some content", location: "some content", summary: "some content", video_transcript: "some content", video_url: "some content", website: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, proposal_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing proposals"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, proposal_path(conn, :new)
    assert html_response(conn, 200) =~ "New proposal"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, proposal_path(conn, :create), proposal: @valid_attrs
    assert redirected_to(conn) == proposal_path(conn, :index)
    assert Repo.get_by(Proposal, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, proposal_path(conn, :create), proposal: @invalid_attrs
    assert html_response(conn, 200) =~ "New proposal"
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

  test "renders form for editing chosen resource", %{conn: conn} do
    proposal = Repo.insert! %Proposal{}
    conn = get conn, proposal_path(conn, :edit, proposal)
    assert html_response(conn, 200) =~ "Edit proposal"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    proposal = Repo.insert! %Proposal{}
    conn = put conn, proposal_path(conn, :update, proposal), proposal: @valid_attrs
    assert redirected_to(conn) == proposal_path(conn, :show, proposal)
    assert Repo.get_by(Proposal, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    proposal = Repo.insert! %Proposal{}
    conn = put conn, proposal_path(conn, :update, proposal), proposal: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit proposal"
  end

  test "deletes chosen resource", %{conn: conn} do
    proposal = Repo.insert! %Proposal{}
    conn = delete conn, proposal_path(conn, :delete, proposal)
    assert redirected_to(conn) == proposal_path(conn, :index)
    refute Repo.get(Proposal, proposal.id)
  end
end
