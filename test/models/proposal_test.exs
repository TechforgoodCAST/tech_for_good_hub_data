defmodule TechForGoodHub.ProposalTest do
  use TechForGoodHub.ModelCase

  alias TechForGoodHub.Proposal

  @valid_attrs %{amount_applied: 42, development_stage: "some content", graphic_url: "some content", location: "some content", summary: "some content", video_transcript: "some content", video_url: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Proposal.changeset(%Proposal{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Proposal.changeset(%Proposal{}, @invalid_attrs)
    refute changeset.valid?
  end
end
