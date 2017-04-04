defmodule TechForGoodHub.Organisation do
  use TechForGoodHub.Web, :model

  schema "organisations" do
    field :name, :string
    field :website, :string
    field :charity_number, :string
    field :company_number, :string
    field :type, :string
    field :income_band, :string
    has_many :Proposals, TechForGoodHub.Proposal

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :website, :charity_number, :company_number, :type, :income_band])
    |> validate_required([:name])
  end
end
