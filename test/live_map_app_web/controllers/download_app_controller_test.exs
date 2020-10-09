defmodule LiveMapAppWeb.DownloadAppControllerTest do
  use LiveMapAppWeb.ConnCase, async: false
  import Tesla.Mock

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @geocoding_empty_response %{
    "results" => [
      %{
        "address_components" => [
          %{
            "long_name" => "улица Орхидея",
            "short_name" => "улица Орхидея",
            "types" => ["route"]
          },
          %{
            "long_name" => "Plovdiv",
            "short_name" => "Plovdiv",
            "types" => ["administrative_area_level_1", "political"]
          },
          %{
            "long_name" => "4130",
            "short_name" => "4130",
            "types" => ["postal_code"]
          }
        ],
      }
    ],
    "status" => "OK"
  }
  @geocoding_response %{
    "plus_code" => %{
      "compound_code" => "52XM+X5 Belozem, Bulgaria",
      "global_code" => "8GJ752XM+X5"
    },
    "results" => [
      %{
        "address_components" => [
          %{
            "long_name" => "улица Орхидея",
            "short_name" => "улица Орхидея",
            "types" => ["route"]
          },
          %{
            "long_name" => "Plovdiv",
            "short_name" => "Plovdiv",
            "types" => ["administrative_area_level_1", "political"]
          },
          %{
            "long_name" => "Bulgaria",
            "short_name" => "BG",
            "types" => ["country", "political"]
          },
          %{
            "long_name" => "4130",
            "short_name" => "4130",
            "types" => ["postal_code"]
          }
        ],
      }
    ],
    "status" => "OK"
  }
  @valid_attributes %{
    "latitude" => "12.5",
    "longitude" => "30.5",
    "app_id"=> "testMeHard",
    "downloaded_at"=> "2018-09-28T09:31:32.223Z"
  }

  @geocoding_url "https://maps.googleapis.com/maps/api/geocode/json"

  describe "/add_download" do
    test "creates a downloaded app with all the parameters", %{conn: conn} do
      mock(fn
        %{method: :get, url: @geocoding_url} ->
        %Tesla.Env{status: 200, body: Jason.encode!(@geocoding_response)}
      end)

      conn = post(conn, Routes.download_app_path(conn, :add_download,@valid_attributes ))
      assert json_response(conn, 201) == "created"
    end

    test "creates a downloaded app with all the parameters event if geocoding does not answer", %{conn: conn} do
      mock(fn
        %{method: :get, url: @geocoding_url} ->
        %Tesla.Env{status: 500, body: "ImBroken"}
        end)
      conn = post(conn, Routes.download_app_path(conn, :add_download,@valid_attributes ))
      assert json_response(conn, 201) == "created"
    end

    test "creates a downloaded app with all the parameters event if geocoding answer is empty", %{conn: conn} do
      mock(fn
        %{method: :get, url: @geocoding_url} ->
        %Tesla.Env{status: 200, body: Jason.encode!(%{result: []})}
        end)

      conn = post(conn, Routes.download_app_path(conn, :add_download,@valid_attributes ))
      assert json_response(conn, 201) == "created"
    end

    test "creates a downloaded app with all the parameters event if geocoding answer doesn't have a country", %{conn: conn} do
      mock(fn
        %{method: :get, url: @geocoding_url} ->
        %Tesla.Env{status: 200, body: Jason.encode!(@geocoding_empty_response)}
        end)

      conn = post(conn, Routes.download_app_path(conn, :add_download,@valid_attributes ))
      assert json_response(conn, 201) == "created"
    end


    test "returns an error with missing parameters", %{conn: conn} do
      conn = post(conn, Routes.download_app_path(conn, :add_download, %{parameter: "isInvalid"}))
      assert json_response(conn, 400) == "invalid_json_body"
    end

    test "returns an error with invalid latitude", %{conn: conn} do
      conn = post(conn, Routes.download_app_path(conn, :add_download,  %{
        "latitude" => "ciao",
        "longitude" => "30.5",
        "app_id"=> "testMeHard",
        "downloaded_at"=> "2018-09-28T09:31:32.223Z"
      }))
      assert json_response(conn, 400) == "invalid_paramters"
    end

    test "returns an error with invalid longitude", %{conn: conn} do
      conn = post(conn, Routes.download_app_path(conn, :add_download,  %{
        "latitude" => "30.5",
        "longitude" => "ciao",
        "app_id"=> "testMeHard",
        "downloaded_at"=> "2018-09-28T09:31:32.223Z"
      }))
      assert json_response(conn, 400) == "invalid_paramters"
    end

    test "returns an error with invalid download time", %{conn: conn} do
      conn = post(conn, Routes.download_app_path(conn, :add_download,  %{
        "latitude" => "30.5",
        "longitude" => "30.5",
        "app_id"=> "testMeHard",
        "downloaded_at"=> "notValidDate"
      }))
      assert json_response(conn, 400) == "invalid_paramters"
    end
  end
end
