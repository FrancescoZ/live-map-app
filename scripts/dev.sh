#!/bin/bash

set -ex

cd assets
npm install
cd ..

mix deps.get
mix compile
mix do ecto.create, ecto.migrate

echo "run docker exec -it ${HOSTNAME} sh in another console to jump into the container!"

tail -f /dev/null
