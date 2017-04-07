defmodule TechForGoodHub.Proposal do
  use TechForGoodHub.Web, :model

  schema "proposals" do
    field :summary, :string
    field :location, :string
    field :graphic_url, :string
    field :website, :string
    field :video_url, :string
    field :video_transcript, :string
    field :development_stage, :string
    field :amount_applied, :decimal
    belongs_to :organisation, TechForGoodHub.Organisation
    many_to_many :tags, TechForGoodHub.Tag, join_through: "taggings"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:organisation_id, :summary, :location, :graphic_url, :website, :video_url, :video_transcript, :development_stage, :amount_applied])
    |> assoc_constraint(:organisation)
    |> validate_required([:summary, :location, :graphic_url, :video_url])
  end

  @doc """
  Returns an Ecto.Query for `query` model tagged with `slug`
  """
  def tagged(query, slug) do
    from proposal in query,
    join: tag in assoc(proposal, :tags),
    where: tag.slug == ^slug,
    select: proposal,
    preload: [:tags, :organisation]
  end

  @doc """
  Returns an Ecto.Query for `query` model tagged with a list of `tags` names
  """
  def filter_by_tags(query, tags) do
    if tags == ["all"] do # REVIEW: consider alternative guard clause
      from proposal in query,
      select: proposal,
      preload: [:organisation, :tags]
    else
      from proposal in query,
      join: tag in assoc(proposal, :tags),
      where: tag.slug in ^tags,
      group_by: proposal.id,
      having: count(proposal.id) == ^length(tags),
      select: proposal,
      preload: [:organisation, :tags]
    end
  end
end
