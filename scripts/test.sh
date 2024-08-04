#!/bin/bash

set -eu

docker compose -f docker-compose.yml -f docker-compose.test.yml run --rm web bundle exec rspec
