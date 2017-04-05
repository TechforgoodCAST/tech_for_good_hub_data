defmodule TechForGoodHub.TagTest do
  use TechForGoodHub.ModelCase

  alias TechForGoodHub.Tag

  @valid_attrs %{category: "Category", name: "Name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tag.changeset(%Tag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tag.changeset(%Tag{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "unique slug" do
    %Tag{}
    |> Tag.changeset(@valid_attrs)
    |> TechForGoodHub.Repo.insert!

    tag2 = Tag.changeset(%Tag{}, @valid_attrs)

    assert {:error, changeset} = Repo.insert(tag2)
    assert elem(changeset.errors[:slug], 0) == "has already been taken"
  end

  test "valid slug" do
    {:ok, changeset} = Repo.insert(Tag.changeset(%Tag{}, @valid_attrs))
    assert changeset.slug == "category-name"
  end
end
