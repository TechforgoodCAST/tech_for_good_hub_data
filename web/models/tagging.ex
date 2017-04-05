defmodule TechForGoodHub.Tagging do
  use TechForGoodHub.Web, :model

  schema "taggings" do
    belongs_to :proposal, TechForGoodHub.Proposal
    belongs_to :tag, TechForGoodHub.Tag

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:proposal_id, :tag_id])
    |> validate_required([:proposal_id, :tag_id])
  end
end
