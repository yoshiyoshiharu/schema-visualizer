#!/bin/bash

set -eu

docker compose run --rm web bundle exec rubocop -A
docker compose run --rm web bundle exec erblint --lint-all -a
docker compose run --rm web bash -c '
  shopt -s dotglob globstar nullglob && bundle exec htmlbeautifier **/*.html.erb
'
