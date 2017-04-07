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

  test "#tagged/2 query returns proposals tagged with a given slug" do
    alias TechForGoodHub.Tag
    alias TechForGoodHub.Tagging
    {:ok, tag} = Repo.insert(Tag.changeset(%Tag{}, %{name: "Name", category: "Category"}))
    {:ok, proposal} = Repo.insert(Proposal.changeset(%Proposal{}, @valid_attrs))
    Repo.insert(Tagging.changeset(%Tagging{}, %{proposal_id: proposal.id, tag_id: tag.id}))

    proposals = Repo.all Proposal.tagged(Proposal, tag.slug)

    assert Enum.count(proposals) == 1
  end

  # TODO: refactor
  test "#filter_by_tags/2 query returns proposals for a list of tag names" do
    alias TechForGoodHub.Tag
    alias TechForGoodHub.Tagging

    {:ok, proposal} = Repo.insert(Proposal.changeset(%Proposal{}, @valid_attrs))

    {:ok, tag1} = Repo.insert(Tag.changeset(%Tag{}, %{name: "Tag1", category: "Category"}))
    Repo.insert(Tagging.changeset(%Tagging{}, %{proposal_id: proposal.id, tag_id: tag1.id}))

    {:ok, tag2} = Repo.insert(Tag.changeset(%Tag{}, %{name: "Tag2", category: "Category"}))
    Repo.insert(Tagging.changeset(%Tagging{}, %{proposal_id: proposal.id, tag_id: tag2.id}))

    {:ok, proposal2} = Repo.insert(Proposal.changeset(%Proposal{}, @valid_attrs))
    Repo.insert(Tagging.changeset(%Tagging{}, %{proposal_id: proposal2.id, tag_id: tag2.id}))

    proposals_tag1_tag2 = Repo.all Proposal.filter_by_tags(Proposal, [tag1.slug, tag2.slug])
    assert Enum.count(proposals_tag1_tag2) == 1

    proposals_tag2 = Repo.all Proposal.filter_by_tags(Proposal, [tag2.slug])
    assert Enum.count(proposals_tag2) == 2

    proposals_no_tags = Repo.all Proposal.filter_by_tags(Proposal, ["all"])
    assert Enum.count(proposals_no_tags) == 2
  end
end
