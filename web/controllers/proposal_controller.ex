defmodule TechForGoodHub.ProposalController do
  use TechForGoodHub.Web, :controller

  alias TechForGoodHub.Proposal
  alias TechForGoodHub.Tag

  def index(conn, _params) do
    proposals = Repo.all(Proposal)
                |> Repo.preload([:organisation, :tags])
    tags = Tag
           |> Tag.get_with_counts()
           |> Repo.all

    render(conn, "index.html", proposals: proposals, tags: tags)
  end

  def show(conn, %{"id" => id}) do
    proposal = Repo.get!(Proposal, id)
               |> Repo.preload([:organisation, :tags])
    render(conn, "show.html", proposal: proposal)
  end

  def tagged(conn, %{"slug" => slug}) do
    tag = Repo.get_by(TechForGoodHub.Tag, slug: slug)
    tags = Proposal
           |> Proposal.tagged(slug)
           |> Repo.all

    render(conn, "tagged.html", tag: tag, proposals: tags)
  end

  def filter(conn, params) do
    tags = String.split params["tags"], ","
    proposals = Proposal
                |> Proposal.filter_by_tags(tags)
                |> Repo.all

    render conn, "_proposals_list.html", layout: false, proposals: proposals
  end
end
