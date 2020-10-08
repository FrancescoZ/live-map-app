defmodule LiveMapAppWeb.DownloadAppControllerTest do
  use LiveMapAppWeb.ConnCase, async: false
  import Tesla.Mock

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

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
        "formatted_address" => "улица Орхидея, 4130, Bulgaria",
        "geometry" => %{
          "bounds" => %{
            "northeast" => %{"lat" => 42.1994342, "lng" => 25.0352197},
            "southwest" => %{"lat" => 42.198593, "lng" => 25.0328989}
          },
          "location" => %{"lat" => 42.1993731, "lng" => 25.0343885},
          "location_type" => "GEOMETRIC_CENTER",
          "viewport" => %{
            "northeast" => %{"lat" => 42.2003625802915, "lng" => 25.0354082802915},
            "southwest" => %{"lat" => 42.1976646197085, "lng" => 25.0327103197085}
          }
        },
        "place_id" => "ChIJ_9rqi5QpqEARBhEtLZDCKa8",
        "types" => ["route"]
      },
      %{
        "address_components" => [
          %{
            "long_name" => "4130",
            "short_name" => "4130",
            "types" => ["postal_code"]
          },
          %{
            "long_name" => "Plovdiv Province",
            "short_name" => "Plovdiv Province",
            "types" => ["administrative_area_level_1", "political"]
          },
          %{
            "long_name" => "Bulgaria",
            "short_name" => "BG",
            "types" => ["country", "political"]
          }
        ],
        "formatted_address" => "4130, Bulgaria",
        "geometry" => %{
          "bounds" => %{
            "northeast" => %{"lat" => 42.2280615, "lng" => 25.1006512},
            "southwest" => %{"lat" => 42.1638321, "lng" => 24.9912784}
          },
          "location" => %{"lat" => 42.1961928, "lng" => 25.0371765},
          "location_type" => "APPROXIMATE",
          "viewport" => %{
            "northeast" => %{"lat" => 42.2280615, "lng" => 25.1006512},
            "southwest" => %{"lat" => 42.1638321, "lng" => 24.9912784}
          }
        },
        "place_id" => "ChIJM9Be3bgpqEARcN07rD-hGHM",
        "types" => ["postal_code"]
      },
      %{
        "address_components" => [
          %{
            "long_name" => "Rakovski",
            "short_name" => "Rakovski",
            "types" => ["administrative_area_level_2", "political"]
          },
          %{
            "long_name" => "Plovdiv Province",
            "short_name" => "Plovdiv Province",
            "types" => ["administrative_area_level_1", "political"]
          },
          %{
            "long_name" => "Bulgaria",
            "short_name" => "BG",
            "types" => ["country", "political"]
          }
        ],
        "formatted_address" => "Rakovski, Bulgaria",
        "geometry" => %{
          "bounds" => %{
            "northeast" => %{"lat" => 42.3406758, "lng" => 25.1006512},
            "southwest" => %{"lat" => 42.1395659, "lng" => 24.8116617}
          },
          "location" => %{"lat" => 42.2793177, "lng" => 24.9993886},
          "location_type" => "APPROXIMATE",
          "viewport" => %{
            "northeast" => %{"lat" => 42.3406758, "lng" => 25.1006512},
            "southwest" => %{"lat" => 42.1395659, "lng" => 24.8116617}
          }
        },
        "place_id" => "ChIJp-v4hCMrqEARJnNuGC8R5n4",
        "types" => ["administrative_area_level_2", "political"]
      },
      %{
        "address_components" => [
          %{
            "long_name" => "Plovdiv Province",
            "short_name" => "Plovdiv Province",
            "types" => ["administrative_area_level_1", "political"]
          },
          %{
            "long_name" => "Bulgaria",
            "short_name" => "BG",
            "types" => ["country", "political"]
          }
        ],
        "formatted_address" => "Plovdiv Province, Bulgaria",
        "geometry" => %{
          "bounds" => %{
            "northeast" => %{"lat" => 42.7935849, "lng" => 25.3480643},
            "southwest" => %{"lat" => 41.682939, "lng" => 24.3568825}
          },
          "location" => %{"lat" => 42.135281, "lng" => 24.7454204},
          "location_type" => "APPROXIMATE",
          "viewport" => %{
            "northeast" => %{"lat" => 42.7935849, "lng" => 25.3480643},
            "southwest" => %{"lat" => 41.682939, "lng" => 24.3568825}
          }
        },
        "place_id" => "ChIJ-8N2V7vRrBQRkFS_aRKgAAM",
        "types" => ["administrative_area_level_1", "political"]
      },
      %{
        "address_components" => [
          %{
            "long_name" => "Bulgaria",
            "short_name" => "BG",
            "types" => ["country", "political"]
          }
        ],
        "formatted_address" => "Bulgaria",
        "geometry" => %{
          "bounds" => %{
            "northeast" => %{"lat" => 44.2153059, "lng" => 28.7292001},
            "southwest" => %{"lat" => 41.2354469, "lng" => 22.3573446}
          },
          "location" => %{"lat" => 42.733883, "lng" => 25.48583},
          "location_type" => "APPROXIMATE",
          "viewport" => %{
            "northeast" => %{"lat" => 44.2153059, "lng" => 28.7292001},
            "southwest" => %{"lat" => 41.2354469, "lng" => 22.3573446}
          }
        },
        "place_id" => "ChIJifBbyMH-qEAREEy_aRKgAAA",
        "types" => ["country", "political"]
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

    test "creates a downloaded app with all the parameters event if geocoding do not answer", %{conn: conn} do
      mock(fn
        %{method: :get, url: @geocoding_url} ->
        %Tesla.Env{status: 500, body: "ImBroken"}
        end)
      conn = post(conn, Routes.download_app_path(conn, :add_download,@valid_attributes ))
      assert json_response(conn, 201) == "created"
    end

    test "creates a downloaded app with all the parameters event if geocoding as no answer", %{conn: conn} do
      mock(fn
        %{method: :get, url: @geocoding_url} ->
        %Tesla.Env{status: 200, body: Jason.encode!(%{result: []})}
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
