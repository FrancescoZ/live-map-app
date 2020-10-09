defmodule LiveMapAppWeb.AppLiveTest do
  use LiveMapAppWeb.ConnCase

  import Phoenix.LiveViewTest

  alias LiveMapApp.Dashboard

  @create_attrs %{app_id: "some app_id", download_at: "2010-04-17T14:00:00Z", latitude: "120.5", longitude: "120.5"}

  defp fixture(:app) do
    {:ok, app} = Dashboard.create_app(@create_attrs)
    app
  end

  defp create_app(_) do
    app = fixture(:app)
    %{app: app}
  end

  describe "Index" do
    setup [:create_app]

    test "contains dashboards", %{conn: conn, app: _app} do
      {:ok, _index_live, html} = live(conn, Routes.app_index_path(conn, :index))

      assert html =~ "Downladed App"
      assert html =~ "Dashboard by Day"
      assert html =~ "Dashboard by Year"
      assert html =~ "Dashboard by Month"
      assert html =~ "Dashboard by App"
      assert html =~ "Dashboard by country"
    end

    test "lists all apps", %{conn: conn, app: app} do
      {:ok, _index_live, html} = live(conn, Routes.app_index_path(conn, :index))

      assert html =~ "Downladed App"
      assert html =~ app.app_id
    end

    test "contains marker", %{conn: conn, app: _app} do
      {:ok, _index_live, html} = live(conn, Routes.app_index_path(conn, :index))

      assert html =~ "Downladed App"
      assert html =~ "position: { lat: 120.5, lng: 120.5 }"
    end
  end
end
