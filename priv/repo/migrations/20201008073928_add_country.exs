defmodule LiveMapApp.Repo.Migrations.AddCountry do
  use Ecto.Migration

  def change do
    alter table(:apps) do
      add :country, :string, default: "Unknown"
    end
  end
end
