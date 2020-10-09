defmodule LiveMapApp.Dashboard do
  @moduledoc """
  The Dashboard context.
  """

  import Ecto.Query, warn: false
  alias LiveMapApp.Repo

  alias LiveMapApp.Dashboard.App

  @doc """
  Returns the list of apps.

  ## Examples

      iex> list_apps()
      [%App{}, ...]

  """
  def list_apps do
    Repo.all(App)
  end

  @doc """
  Gets a single app.

  Raises `Ecto.NoResultsError` if the App does not exist.

  ## Examples

      iex> get_app!(123)
      %App{}

      iex> get_app!(456)
      ** (Ecto.NoResultsError)

  """
  def get_app!(id), do: Repo.get!(App, id)

  @doc """
  Creates a app.

  ## Examples

      iex> create_app(%{field: value})
      {:ok, %App{}}

      iex> create_app(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_app(attrs \\ %{}) do
    %App{}
    |> App.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:download_added)
  end

  @doc """
  Deletes a app.

  ## Examples

      iex> delete_app(app)
      {:ok, %App{}}

      iex> delete_app(app)
      {:error, %Ecto.Changeset{}}

  """
  def delete_app(%App{} = app) do
    Repo.delete(app)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking app changes.

  ## Examples

      iex> change_app(app)
      %Ecto.Changeset{data: %App{}}

  """
  def change_app(%App{} = app, attrs \\ %{}) do
    App.changeset(app, attrs)
  end

  def subscribe do
    Phoenix.PubSub.subscribe(LiveMapApp.PubSub, "apps")
  end

  defp broadcast({:error, _reason} = error, _event), do: error

  defp broadcast({:ok, app}, :download_added = event) do
    Phoenix.PubSub.broadcast(LiveMapApp.PubSub, "apps", {event, app})
    Phoenix.PubSub.broadcast(LiveMapApp.PubSub, "apps", {:new_marker, app})
    {:ok, app}
  end

  defp broadcast({:ok, app}, event) do
    Phoenix.PubSub.broadcast(LiveMapApp.PubSub, "apps", {event, app})
    {:ok, app}
  end
end
