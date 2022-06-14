FROM ruby:2.7.5

RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

RUN chmod +x entrypoint.sh

# helpful when trying to update gems -> bundle update, remove the Gemfile.lock, start ruby
# RUN bundle update
# RUN rm -vf /usr/src/app/Gemfile.lock

HEALTHCHECK --interval=10s --timeout=3s \
  CMD curl -f -s http://localhost:3000 || exit 1

EXPOSE 3000
ENTRYPOINT ["bash","entrypoint.sh"]