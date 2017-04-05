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
    render(conn, "show.html", proposal: proposal)
  end

  def tagged(conn, %{"slug" => slug}) do
    tags = Proposal.tagged(slug)
    tag = Repo.get_by(TechForGoodHub.Tag, slug: slug)
    render(conn, "tagged.html", tag: tag, proposals: tags)
  end
end
