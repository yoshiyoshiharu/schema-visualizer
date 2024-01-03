#!/bin/bash

set -eu

docker compose run --rm web bundle exec rspec
