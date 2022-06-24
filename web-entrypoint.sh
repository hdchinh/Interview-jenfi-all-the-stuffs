#!/bin/bash
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed

rm -f /rails/tmp/pids/server.pid

bundle exec puma -C config/puma.rb
