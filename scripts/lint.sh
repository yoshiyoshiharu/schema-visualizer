docker compose run --rm web bundle exec rubocop
docker compose run --rm web bundle exec erblint --lint-all
docker compose run --rm web bash -c '
  shopt -s dotglob globstar nullglob && bundle exec htmlbeautifier -l **/*.html.erb
'
docker compose run --rm web bundle exec brakeman -Aqw1 --no-pager
