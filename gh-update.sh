#!/usr/bin/env bash
# set -x	# uncomment for verbosity
if [[ $PWD != /graphhopper ]]; then
  echo "Launching Docker to build a new cache"
  docker-compose run --rm --entrypoint /usr/src/app/$(basename $0) graphhopper
  if [[ "$(docker-compose ps -q graphhopper)" == "" ]]; then
    docker-compose up -d  graphhopper
  else
    docker-compose restart graphhopper
  fi
else
  echo "Building a new cache"
  [ -d /data/new-gh ] && rm -fr /data/new-gh
  mkdir -p /data/new-gh
  ./graphhopper.sh import asia_israel-and-palestine.pbf -c /usr/src/app/gh-config.yml -fd -o /data/new-gh/
  echo "Pushing the new cache"
  rm -fr /data/default-gh
  mv /data/new-gh /data/default-gh
fi
