defmodule TechForGoodHub.Repo.Migrations.AddFieldsToProposals do
  use Ecto.Migration

  def change do
    alter table(:proposals) do
      add :status, :string
      add :region, :string
      add :year, :integer
    end
  end
end
