FROM ruby:3.2.2-slim-bullseye

WORKDIR /myapp

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  libmariadb-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY config.ru Rakefile ./
COPY bin bin

COPY Gemfile Gemfile.lock ./
RUN bundle install -j8

COPY config config
COPY lib lib
COPY db db
COPY public public
COPY app app

COPY .env .env
RUN env $(cat .env) bundle exec rails assets:precompile && rm -f .env
