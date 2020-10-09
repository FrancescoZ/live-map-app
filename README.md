# LiveMapApp

This is a really simple [Phoenix LiveView]() Application to get real time information about app downloads using a map and different dashboards.

The creation of this project is described in [this article]()

## Development
### Requirements
The solution is using docker so be sure to have installed `docker-compose` and `Docker` on your machine before starting.

:warning: Important Step :warning:

You will need a GoogleApiKey, you can get one by following [this tutorial](https://developers.google.com/maps/documentation/javascript/get-api-key). You need to enable it for:
- Geocoding API
- Maps JavaScript API

Once you have it you have to copy it in the `API_TOKEN` environment variable in the `/env/dev.env` file.

### How to launch it
Once you have clone the repo you just need to go into the folder and run:
> docker-compose up

As default the container is created, dependencies are installed, database is created and migrated but no application is started. This allow you to jump into the container and run test if you want to.
To jump into the container you can copy the output of the `docker-compose up` into another console or run this:
> docker exec -it HOSTNAME sh

replacing HOSTNAME with the container id.
To start the server you need to go run:
> mix phx.server

The server will start listening on the port `4000`, which is forwared from the container at the port `4005`

### How to run tests
Inside the container you can run unit test using:
> MIX_ENV=test mix test

## Usage
To start using the service you need to start it using the instruction above.

In order send information to the service you have to hit the endpoint with the correct parameters:
- longitude, must be a number
- latitude, must be a number
- downloaded_at, must be a date in the ISO format (i.e T22:31:32.223Z)

An example:
> curl --location --request POST 'localhost:4005/add_downaload' \
--form 'longitude=-14.00' \
--form 'latitude=-50.0' \
--form 'downloaded_at=2021-10-11T22:31:32.223Z' \
--form 'app_id=test23'

To interact with the application you can go to [localhost:4005](http://localhost:4005/)

## Future Improvements and welcome MRs
- More unit tests, especially in the View part and hooks, using this
- More explicit error message in the endpoint
- Service level tests
- Heatmap Layer usint [this](https://developers.google.com/maps/documentation/javascript/heatmaplayer)
