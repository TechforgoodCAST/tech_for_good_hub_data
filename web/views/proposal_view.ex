  defmodule TechForGoodHub.ProposalView do
  use TechForGoodHub.Web, :view

  @doc """
    Renders HTML option tags for a given `Tag.category`.

      iex> tags = [%TechForGoodHub.Tag{name: "Name", category: "Category", slug: "category-name"}]
      iex> TechForGoodHub.ProposalView.render_options(tags, "Category")
      {:safe, ["<option value='category-name'>Name</option>"]}
  """
  def render_options(tags, category) do
    tags
    |> Enum.filter(fn(tag) -> tag.category == category end)
    |> Enum.uniq
    |> Enum.map(fn(tag) ->
      "<option value='#{tag.slug}'>#{tag.name}</option>"
    end)
    |> Phoenix.HTML.raw
  end

  def render_regions() do
    # @TODO shouldn't be hardcoded here, duplicated with models/proposal.ex:69
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
    regions
    |> Enum.map(fn {region_slug, region} ->
      "<option value='#{region_slug}'>#{region}</option>"
    end)
    |> Phoenix.HTML.raw
  end

  def categories do
    [
      %{ name: "Approach", category: "approach-type" },
      %{ name: "Focus", category: "focus" },
      %{ name: "Audience", category: "target-audience" },
      %{ name: "Tech", category: "tech-type" }
    ]
  end

  def categories(category) do
    categories()
    |> Enum.filter(fn(c) -> c.category == category end)
  end
end
