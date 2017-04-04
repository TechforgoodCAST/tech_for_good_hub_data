defmodule TechForGoodHub.ProposalController do
  use TechForGoodHub.Web, :controller

  alias TechForGoodHub.Proposal

  def index(conn, _params) do
    proposals = Repo.all(Proposal)
                |> Repo.preload(:organisation)
    render(conn, "index.html", proposals: proposals)
  end

  def new(conn, _params) do
    changeset = Proposal.changeset(%Proposal{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"proposal" => proposal_params}) do
    changeset = Proposal.changeset(%Proposal{}, proposal_params)

    case Repo.insert(changeset) do
      {:ok, _proposal} ->
        conn
        |> put_flash(:info, "Proposal created successfully.")
        |> redirect(to: proposal_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    proposal = Repo.get!(Proposal, id)
    render(conn, "show.html", proposal: proposal)
  end

  def edit(conn, %{"id" => id}) do
    proposal = Repo.get!(Proposal, id)
    changeset = Proposal.changeset(proposal)
    render(conn, "edit.html", proposal: proposal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "proposal" => proposal_params}) do
    proposal = Repo.get!(Proposal, id)
    changeset = Proposal.changeset(proposal, proposal_params)

    case Repo.update(changeset) do
      {:ok, proposal} ->
        conn
        |> put_flash(:info, "Proposal updated successfully.")
        |> redirect(to: proposal_path(conn, :show, proposal))
      {:error, changeset} ->
        render(conn, "edit.html", proposal: proposal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    proposal = Repo.get!(Proposal, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(proposal)

    conn
    |> put_flash(:info, "Proposal deleted successfully.")
    |> redirect(to: proposal_path(conn, :index))
  end
end
