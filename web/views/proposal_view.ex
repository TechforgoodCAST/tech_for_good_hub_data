defmodule TechForGoodHub.ProposalView do
  use TechForGoodHub.Web, :view

  @doc """
    Renders HTML option tags for a given `Tag.category`.

      iex> tags = [%TechForGoodHub.Tag{name: "Name", category: "Category", slug: "category-name"}]
      iex> TechForGoodHub.ProposalView.render_options(tags, "Category")
      {:safe, ["<option value='Name'>Name</option>"]}
  """
  def render_options(tags, category) do
    tags
    |> Enum.filter(fn(tag) -> tag.category == category end)
    |> Enum.uniq
    |> Enum.map(fn(tag) ->
      "<option value='#{tag.name}'>#{tag.name}</option>"
    end)
    |> Phoenix.HTML.raw
  end
end
