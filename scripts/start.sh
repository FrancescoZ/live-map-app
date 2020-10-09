#!/bin/bash

set -ex

mix deps.get
mix do ecto.create, ecto.migrate
mix phx.server
