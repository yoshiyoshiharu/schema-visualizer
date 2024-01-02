#!/bin/bash -eu

docker compose run --rm web bundle exec rspec
