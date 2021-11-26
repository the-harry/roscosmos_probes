FROM ruby:3.0.2

WORKDIR /roscosmos_probes

RUN apt-get update && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v 2.2.22 && bundle _2.2.22_ install
