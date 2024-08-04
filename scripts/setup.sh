#!/bin/bash

set -eu

docker compose build
docker compose run --rm web bundle exec rails db:drop db:create db:migrate db:seed
docker compose run --rm web bundle exec rails db:drop db:create db:migrate RAILS_ENV=test
