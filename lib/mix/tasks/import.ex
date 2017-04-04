defmodule Mix.Tasks.TechForGoodHub.Import do
  use Mix.Task
  alias TechForGoodHub.Repo
  alias TechForGoodHub.Organisation
  alias TechForGoodHub.Proposal

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

    Enum.each(data, fn(map) ->
      create_or_insert_organisation(map)
      create_proposal(map)
    end)
  end

  defp create_or_insert_organisation(map) do
    case Repo.get_by(Organisation, name: org_values(map)["org_name"]) do
      nil  -> %Organisation{name: org_values(map)["org_name"]}
      organisation -> organisation
    end
    |> Organisation.changeset(org_values(map))
    |> Repo.insert_or_update
  end

  defp create_proposal(map) do
    changeset = Proposal.changeset %Proposal{}, proposal_values(map)
    case Repo.insert(changeset) do
      {:ok, _} -> IO.puts "Proposal created successfully."
      {:error, changeset} -> IO.puts changeset.errors
    end
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
      "development_stage" => map["form_data"]["development-stage"],
    })
  end

  defp read_json(file) do
    case File.read file do
      {:ok, data} -> data
      {:error, error} -> IO.puts error
    end
  end
end
