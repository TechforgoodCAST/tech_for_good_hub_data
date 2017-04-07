defmodule Mix.Tasks.TechForGoodHub.Import do
  use Mix.Task
  alias TechForGoodHub.Repo
  alias TechForGoodHub.Organisation
  alias TechForGoodHub.Proposal
  alias TechForGoodHub.Tag
  alias TechForGoodHub.Tagging

  @shortdoc "Imports data for Tech For Good Hub"

  @moduledoc """
    Imports data for Tech For Good Hub.

    It expects a path to a JSON file as argument.

      mix tech_for_good_hub.import "/path/to/file.json"
  """

  def run(file_path) do
    Mix.Task.run "app.start"

    data = Poison.decode! read_json(file_path)

    Repo.delete_all(Organisation)
    Repo.delete_all(Tag)

    Enum.each(data, fn(map) ->
      create_or_insert_organisation(map)
      create_proposal(map)
      |> create_tags(map)
    end)
  end

  defp create_or_insert_organisation(map) do
    case Repo.get_by(Organisation, name: org_values(map)["org_name"]) do
      nil -> %Organisation{name: org_values(map)["org_name"]}
      organisation -> organisation
    end
    |> Organisation.changeset(org_values(map))
    |> Repo.insert_or_update
  end

  defp create_proposal(map) do
    changeset = Proposal.changeset %Proposal{}, proposal_values(map)
    case Repo.insert(changeset) do
      {:ok, proposal} -> proposal
      {:error, changeset} -> IO.puts changeset.errors
    end
  end

  defp create_tags(proposal, map) do
    # TODO: refactor
    get_in(map, ["form_data"])
    |> Map.take(["approach-type", "key-problems", "target-audience", "tech-type"])
    |> Enum.each(fn(i) ->
      {k, v} = i
      case v do
        [] -> false
        _ -> Enum.each(v, fn(name) ->
          case name do
            nil -> false
            "" -> false
            _ -> (
              changeset = Tag.changeset %Tag{}, %{name: name, category: k}

              case Repo.get_by(Tag, slug: Ecto.Changeset.get_field(changeset, :slug)) do
                nil -> %Tag{slug: Ecto.Changeset.get_field(changeset, :slug)}
                tag -> tag
              end
              |> Tag.changeset(%{name: name, category: k})
              |> Repo.insert_or_update
              |> case do
                {:ok, tag} -> create_taggings(proposal.id, tag.id)
                {:error, error} -> error
              end
            )
          end
        end)
      end
    end)
  end

  defp create_taggings(proposal_id, tag_id) do
    Tagging.changeset(%Tagging{}, %{proposal_id: proposal_id, tag_id: tag_id})
    |> Repo.insert
  end

  defp org_values(map) do
    Map.take(map, ["org_name", "org_website", "recon"])
    |> Map.merge(%{
         "name"           => map["org_name"],
         "website"        => map["org_website"],
         "charity_number" => map["recon"]["ccnum"],
         "company_number" => map["recon"]["coyno"],
         "type"           => map["recon"]["org_type"],
         "income_band"    => to_string(map["recon"]["charity_data"]["mainCharity"]["income"])
       })
  end

  defp proposal_values(map) do
    Map.take(map, ["org_name", "summary", "amount", "location", "project_website", "video", "video_transcript", "development_stage"])
    |> Map.merge(%{
      "organisation_id"   => Repo.get_by(Organisation, name: map["org_name"]).id,
      "video_url"         => map["video"],
      "graphic_url"       => map["graphic"],
      "website"           => map["project_website"],
      "amount_applied"    => map["amount"],
      "development_stage" => map["form_data"]["development-stage"],
    })
  end

  defp read_json(file) do
    case File.read file do
      {:ok, data} -> data
      {:error, _} -> HTTPoison.get(file)
      |> case do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body
        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end
    end
  end
end
