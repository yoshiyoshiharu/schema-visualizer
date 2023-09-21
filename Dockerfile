FROM ruby:3.2.2-alpine

WORKDIR /myapp

RUN apk add --no-cache build-base postgresql-dev tzdata yarn shared-mime-info

COPY Gemfile Gemfile.lock ./
RUN bundle install -j4

COPY . .
