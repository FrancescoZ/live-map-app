defmodule LiveMapApp.DashboardTest do
  use LiveMapApp.DataCase

  alias LiveMapApp.Dashboard

  describe "apps" do
    alias LiveMapApp.Dashboard.App

    @valid_attrs %{app_id: "some app_id", download_at: "2010-04-17T14:00:00Z", latitude: "120.5", longitude: "120.5", country: "Unknown"}
    @update_attrs %{app_id: "some updated app_id", download_at: "2011-05-18T15:01:01Z", latitude: "456.7", longitude: "456.7"}
    @invalid_attrs %{app_id: nil, download_at: nil, latitude: nil, longitude: nil}

    def app_fixture(attrs \\ %{}) do
      {:ok, app} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create_app()

      app
    end

    test "list_apps/0 returns all apps" do
      app = app_fixture()
      assert Dashboard.list_apps() == [app]
    end

    test "get_app!/1 returns the app with given id" do
      app = app_fixture()
      assert Dashboard.get_app!(app.id) == app
    end

    test "create_app/1 with valid data creates a app" do
      assert {:ok, %App{} = app} = Dashboard.create_app(@valid_attrs)
      assert app.app_id == "some app_id"
      assert app.download_at == DateTime.from_naive!(~N[2010-04-17T14:00:00Z], "Etc/UTC")
      assert app.latitude == Decimal.new("120.5")
      assert app.longitude == Decimal.new("120.5")
    end

    test "create_app/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_app(@invalid_attrs)
    end

    test "delete_app/1 deletes the app" do
      app = app_fixture()
      assert {:ok, %App{}} = Dashboard.delete_app(app)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_app!(app.id) end
    end

    test "change_app/1 returns a app changeset" do
      app = app_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_app(app)
    end
  end
end
