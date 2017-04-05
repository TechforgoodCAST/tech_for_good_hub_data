defmodule TechForGoodHub.Tag do
  use TechForGoodHub.Web, :model

  schema "tags" do
    field :name, :string
    field :slug, :string
    field :category, :string
    many_to_many :proposals, TechForGoodHub.Proposal, join_through: "taggings"

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :slug, :category])
    |> build_slug
    |> unique_constraint(:slug)
    |> validate_required([:name, :slug, :category])
  end

  defp build_slug(changeset) do
    build_slug(get_field(changeset, :slug), get_field(changeset, :category), get_field(changeset, :name))
    |> (&put_change(changeset, :slug, &1)).()
  end

  defp build_slug(nil, category, name), do: "#{generate_slug(category)}-#{generate_slug(name)}"
  defp build_slug(slug, _, _), do: slug

  defp generate_slug(name) do
    if name do
      String.downcase(name)
      |> String.replace(~r/\W/, "-")
    end
  end
end
