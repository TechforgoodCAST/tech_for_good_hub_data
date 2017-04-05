defmodule TechForGoodHub.Repo.Migrations.CreateTagging do
  use Ecto.Migration

  def change do
    create table(:taggings) do
      add :proposal_id, references(:proposals, on_delete: :delete_all)
      add :tag_id, references(:tags, on_delete: :delete_all)

      timestamps()
    end
    create index(:taggings, [:proposal_id])
    create index(:taggings, [:tag_id])
  end
end
