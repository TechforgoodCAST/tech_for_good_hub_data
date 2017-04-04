defmodule TechForGoodHub.Repo.Migrations.CreateProposal do
  use Ecto.Migration

  def change do
    create table(:proposals) do
      add :summary, :text
      add :location, :string
      add :graphic_url, :string, size: 510
      add :website, :string, size: 510
      add :video_url, :string, size: 510
      add :video_transcript, :text
      add :development_stage, :string
      add :amount_applied, :integer
      add :organisation_id, references(:organisations, on_delete: :delete_all)

      timestamps()
    end

    create index(:proposals, [:organisation_id])
  end
end
