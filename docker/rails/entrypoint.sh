#!/bin/sh
set -e

bundle config set force_ruby_platform true

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

if ! bundle check ; then
  bundle install --jobs 4
fi

(bundle exec rails db:migrate:status | grep "^\s*down") && bundle exec rails db:migrate || echo "No pending migrations found."

exec "$@"