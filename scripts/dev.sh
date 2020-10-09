#!/bin/bash

set -ex

mix deps.get

npm install --prefix assets

mix compile
mix do ecto.create, ecto.migrate

echo "run:  docker exec -it ${HOSTNAME} sh  in another console to jump into the container!"

tail -f /dev/null
