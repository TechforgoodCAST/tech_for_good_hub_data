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
    field :status, :string
    field :year, :integer
    field :region, :string
    belongs_to :organisation, TechForGoodHub.Organisation
    many_to_many :tags, TechForGoodHub.Tag, join_through: "taggings"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:organisation_id, :summary, :location, :graphic_url, :website, :video_url, :video_transcript, :development_stage, :amount_applied, :status, :region, :year])
    |> assoc_constraint(:organisation)
    |> validate_required([:summary, :location, :graphic_url, :video_url, :status])
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
  Returns an Ecto.Query for `query` model in category `category`
  """
  def category(query, category) do
    from proposal in query,
    join: tag in assoc(proposal, :tags),
    where: tag.category == ^category,
    select: proposal,
    preload: [:tags, :organisation]
  end

  @doc """
  Returns an Ecto.Query for `query` model tagged with a list of `tags` names
  """


  def filter_by_tags(query, tags) do

    # @TODO Shouldn't be hardcoded and shouldn't be stored here
    statuses = %{
      "status-unsuccessful" => "Unsuccessful",
      "status-longlisted" => "Unsuccessful - longlisted",
      "status-funded" => "Funded"
    }

    regions = %{
      "region-london" => "London",
      "region-north-west" => "North West",
      "region-north-east" => "North East",
      "region-south-west" => "South West",
      "region-south-east" => "South East",
      "region-yorkshire-and-the-humber" => "Yorkshire and the Humber",
      "region-east-midlands" => "East Midlands",
      "region-eastern" => "Eastern",
      "region-west-midlands" => "West Midlands",
      "region-scotland" => "Scotland",
      "region-northern-ireland" => "Northern Ireland",
      "region-wales" => "Wales"
    }

    tags =
      if tags == ["all"] do # REVIEW: consider alternative guard clause
        []
      else
        tags
      end

    # base query
    query = from proposal in query,
      select: proposal,
      preload: [:organisation, :tags]

    status_tags = Enum.filter_map(tags, fn(tag) -> String.starts_with? tag, "status-" end, fn(tag) -> statuses[tag] end)
    region_tags = Enum.filter_map(tags, fn(tag) -> String.starts_with? tag, "region-" end, fn(tag) -> regions[tag] end)
    tags = Enum.filter(tags, fn(tag) -> !String.starts_with? tag, ["status-", "region-"] end)

    if length(tags)>0 do
      query = from proposal in query,
        join: tag in assoc(proposal, :tags),
        where: tag.slug in ^tags,
        group_by: proposal.id,
        having: count(proposal.id) == ^length(tags)
    end

    # check status
    query = if length(status_tags)>0 do
        from proposal in query, where: proposal.status in ^status_tags
      else
        query
      end
    # check region
    query =
      if length(region_tags)>0 do
        from proposal in query, where: proposal.region in ^region_tags
      else
        query
      end

    query
  end
end
