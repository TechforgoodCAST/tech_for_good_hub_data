defmodule TechForGoodHub.ProposalView do
  use TechForGoodHub.Web, :view
  import Phoenix.HTML.SimplifiedHelpers.Truncate

  @doc """
    Renders HTML option tags for a given `Tag.category`.

      iex> tags = [
      ...> %{name: "Last", category: "Category", slug: "category-name", p_count: 10},
      ...> %{name: "first", category: "Category", slug: "category-name", p_count: 20}
      ...> ]
      iex> TechForGoodHub.ProposalView.render_options(tags, "Category")
      {:safe,
       ["<option value='category-name'>first (20)</option>",
        "<option value='category-name'>Last (10)</option>"]}
  """
  def render_options(tags, category) do
    tags
    |> Enum.filter(fn(tag) -> tag.category == category end)
    |> Enum.uniq
    |> Enum.sort(&(String.downcase(&1.name) < String.downcase(&2.name)))
    |> Enum.map(fn(tag) ->
      "<option value='#{tag.slug}'>#{tag.name} (#{tag.p_count})</option>"
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

  @doc """
    Returns the 'name' key from 'categories/0' given a `category`.

      iex> TechForGoodHub.ProposalView.category_name("missing")
      nil
      iex> TechForGoodHub.ProposalView.category_name("tech-type")
      "Tech"
  """
  def category_name(category) do
    Enum.find(categories(), fn(c) -> c.category == category end)[:name]
  end
end
