defmodule TechForGoodHub.OrganisationController do
  use TechForGoodHub.Web, :controller

  alias TechForGoodHub.Organisation

  def index(conn, _params) do
    organisations = Repo.all(Organisation)
    render(conn, "index.html", organisations: organisations)
  end

  def new(conn, _params) do
    changeset = Organisation.changeset(%Organisation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organisation" => organisation_params}) do
    changeset = Organisation.changeset(%Organisation{}, organisation_params)

    case Repo.insert(changeset) do
      {:ok, _organisation} ->
        conn
        |> put_flash(:info, "Organisation created successfully.")
        |> redirect(to: organisation_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organisation = Repo.get!(Organisation, id)
    render(conn, "show.html", organisation: organisation)
  end

  def edit(conn, %{"id" => id}) do
    organisation = Repo.get!(Organisation, id)
    changeset = Organisation.changeset(organisation)
    render(conn, "edit.html", organisation: organisation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organisation" => organisation_params}) do
    organisation = Repo.get!(Organisation, id)
    changeset = Organisation.changeset(organisation, organisation_params)

    case Repo.update(changeset) do
      {:ok, organisation} ->
        conn
        |> put_flash(:info, "Organisation updated successfully.")
        |> redirect(to: organisation_path(conn, :show, organisation))
      {:error, changeset} ->
        render(conn, "edit.html", organisation: organisation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organisation = Repo.get!(Organisation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(organisation)

    conn
    |> put_flash(:info, "Organisation deleted successfully.")
    |> redirect(to: organisation_path(conn, :index))
  end
end
