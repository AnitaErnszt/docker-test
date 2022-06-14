FROM ruby:2.7.5

RUN apt-get update -qq && apt-get install -qqy build-essential nodejs

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install

ENV RAILS_ENV development
ENV RACK_ENV development

COPY . /app

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD bundle exec rails server
