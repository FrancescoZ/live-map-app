#!/bin/bash

set -ex

mix deps.get
mix do ecto.create, ecto.migrate
cd assets
npm install
cd ..
mix phx.server
