FROM ruby:2.4.4-stretch

RUN apt-get update && apt-get install -y \
  build-essential

RUN mkdir -p /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

RUN chgrp -R 0 /app && \
    chmod -R g=u /app

