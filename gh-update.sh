#!/usr/bin/env bash
# set -x	# uncomment for verbosity
if [[ $PWD != /graphhopper ]]; then
  if
    wget -N http://download.geofabrik.de/asia/israel-and-palestine-latest.osm.pbf |& grep "200 OK" > /dev/null
  then
    echo "Launching Docker to build a new cache"
    docker-compose run --rm --entrypoint /usr/src/app/$(basename $0) graphhopper
    if [[ "$(docker-compose ps -q graphhopper)" == "" ]]; then
       docker-compose up -d  graphhopper
    else
        docker-compose restart graphhopper
    fi
  fi
else
  echo "Building a new cache"
  rm -fr /data/new-gh
  mkdir -p /data/new-gh
  ./graphhopper.sh import /usr/src/app/israel-and-palestine-latest.osm.pbf -c /usr/src/app/gh-config.yml -o /data/new-gh/
  echo "Pushing the new cache"
  rm -fr /data/default-gh
  mv /data/new-gh /data/default-gh
fi
