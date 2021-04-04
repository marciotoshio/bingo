#!/bin/bash

set -e

rm -f /myapp/tmp/pids/server.pid

bundle check || bundle install --binstubs="$BUNDLE_BIN"

exec "$@"
