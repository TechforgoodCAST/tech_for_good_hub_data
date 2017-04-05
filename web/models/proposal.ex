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
  Returns a list of proposals tagged with `slug`
  """
  def tagged(slug) do
    TechForGoodHub.Repo.all(
      from p in TechForGoodHub.Proposal,
      join: t in assoc(p, :tags),
      where: t.slug == ^slug,
      select: p,
      preload: [:tags, :organisation]
    )
  end
end
