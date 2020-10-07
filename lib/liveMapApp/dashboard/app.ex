defmodule LiveMapApp.Dashboard.App do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apps" do
    field :app_id, :string
    field :download_at, :utc_datetime
    field :latitude, :decimal
    field :longitude, :decimal

    timestamps()
  end

  @doc false
  def changeset(app, attrs) do
    app
    |> cast(attrs, [:longitude, :latitude, :app_id, :download_at])
    |> validate_required([:longitude, :latitude, :app_id, :download_at])
  end
end
