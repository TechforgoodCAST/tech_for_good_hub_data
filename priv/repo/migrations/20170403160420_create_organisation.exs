defmodule TechForGoodHub.Repo.Migrations.CreateOrganisation do
  use Ecto.Migration

  def change do
    create table(:organisations) do
      add :name, :string
      add :website, :string
      add :charity_number, :string
      add :company_number, :string
      add :type, :string
      add :income_band, :string

      timestamps()
    end

  end
end
