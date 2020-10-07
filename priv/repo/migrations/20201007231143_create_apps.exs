defmodule LiveMapApp.Repo.Migrations.CreateApps do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :longitude, :decimal
      add :latitude, :decimal
      add :app_id, :string
      add :download_at, :utc_datetime

      timestamps()
    end

  end
end
