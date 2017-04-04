defmodule TechForGoodHub.OrganisationTest do
  use TechForGoodHub.ModelCase

  alias TechForGoodHub.Organisation

  @valid_attrs %{charity_number: "some content", company_number: "some content", income_band: "some content", name: "some content", type: "some content", website: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Organisation.changeset(%Organisation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Organisation.changeset(%Organisation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
