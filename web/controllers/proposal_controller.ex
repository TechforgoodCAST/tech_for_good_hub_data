defmodule TechForGoodHub.ProposalController do
  use TechForGoodHub.Web, :controller

  alias TechForGoodHub.Proposal

  def index(conn, _params) do
    proposals = Repo.all(Proposal)
                |> Repo.preload([:organisation, :tags])
    tags = Repo.all(TechForGoodHub.Tag)
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

  def category(conn, params) do
    category = params["category"]
    proposals = Proposal
                |> Proposal.category(category)
                |> Repo.all
    tags = Repo.all(TechForGoodHub.Tag)

    render conn, "category.html", category: category, proposals: proposals, tags: tags
  end
end
