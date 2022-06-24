FROM ruby:2.7.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /rails
COPY Gemfile /rails/Gemfile
COPY Gemfile.lock /rails/Gemfile.lock
RUN bundle install
COPY . /rails

# Add a script to be executed every time the container starts.
COPY web-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/web-entrypoint.sh

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /rails/node_modules

ENTRYPOINT ["web-entrypoint.sh"]
EXPOSE 8080
