#!/bin/zsh  

set -e

rm -f /todo-app/tmp/pids/server.pid

exec "$@"