#!/bin/bash

set -eu

docker compose run --rm web bash rubocop -A
docker compose run --rm web bash -c '
  shopt -s dotglob globstar nullglob && bundle exec htmlbeautifier **/*.html.erb
'
