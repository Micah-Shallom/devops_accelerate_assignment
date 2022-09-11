#!/bin/sh
echo "Starting Container $hostname"
if [ -z "$REQUIRED_ENV" ]; then
  echo "Container failed to start, pls pass -e REQUIRED_ENV=sometest"
  exit 1
fi
echo "starting container with $REQUIRED_ENV"
#your long-running command from CMD
exec "$@"