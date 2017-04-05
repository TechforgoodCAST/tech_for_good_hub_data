defmodule TechForGoodHub.TaggingTest do
  use TechForGoodHub.ModelCase

  alias TechForGoodHub.Tagging

  @valid_attrs %{proposal_id: 1, tag_id: 1}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tagging.changeset(%Tagging{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tagging.changeset(%Tagging{}, @invalid_attrs)
    refute changeset.valid?
  end
end
