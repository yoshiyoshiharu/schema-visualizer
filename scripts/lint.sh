#!/bin/bash -eu

docker compose run --rm web bundle exec rubocop || exit_status=$?
docker compose run --rm web bundle exec erblint --lint-all || exit_status=$?
docker compose run --rm web bash -c '
  shopt -s dotglob globstar nullglob && bundle exec htmlbeautifier -l **/*.html.erb
' || exit_status=$?
docker compose run --rm web bundle exec brakeman -Aqw1 --no-pager || exit_status=$?

exit ${exit_status:-0}
