defmodule TechForGoodHub.OrganisationControllerTest do
  use TechForGoodHub.ConnCase

  alias TechForGoodHub.Organisation
  @valid_attrs %{charity_number: "some content", company_number: "some content", income_band: "some content", name: "some content", type: "some content", website: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, organisation_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing organisations"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, organisation_path(conn, :new)
    assert html_response(conn, 200) =~ "New organisation"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, organisation_path(conn, :create), organisation: @valid_attrs
    assert redirected_to(conn) == organisation_path(conn, :index)
    assert Repo.get_by(Organisation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, organisation_path(conn, :create), organisation: @invalid_attrs
    assert html_response(conn, 200) =~ "New organisation"
  end

  test "shows chosen resource", %{conn: conn} do
    organisation = Repo.insert! %Organisation{}
    conn = get conn, organisation_path(conn, :show, organisation)
    assert html_response(conn, 200) =~ "Show organisation"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, organisation_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    organisation = Repo.insert! %Organisation{}
    conn = get conn, organisation_path(conn, :edit, organisation)
    assert html_response(conn, 200) =~ "Edit organisation"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    organisation = Repo.insert! %Organisation{}
    conn = put conn, organisation_path(conn, :update, organisation), organisation: @valid_attrs
    assert redirected_to(conn) == organisation_path(conn, :show, organisation)
    assert Repo.get_by(Organisation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    organisation = Repo.insert! %Organisation{}
    conn = put conn, organisation_path(conn, :update, organisation), organisation: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit organisation"
  end

  test "deletes chosen resource", %{conn: conn} do
    organisation = Repo.insert! %Organisation{}
    conn = delete conn, organisation_path(conn, :delete, organisation)
    assert redirected_to(conn) == organisation_path(conn, :index)
    refute Repo.get(Organisation, organisation.id)
  end
end
