#!/usr/bin/env bash
# set -x	# uncomment for verbosity
if [[ $PWD != /graphhopper ]]; then
  if [ -d ./elevation ]; then
    echo "Launching Docker to update elevation files"
    if ! (docker-compose run --rm --entrypoint /usr/src/app/$(basename $0) graphhopper); then
      if [[ "$(docker-compose ps -q graphhopper)" != "" ]]; then
	docker-compose restart graphhopper
      fi
    fi
  else
    echo "Source directory ./elevation was not found."
    exit 1
  fi
else
  echo "Updating elevation files"
  copied=0
  for ele in /usr/src/app/elevation/*.hgt.zip ; do
    fname=${ele##*/}
    echo -n "$fname "
    dest=/data/elevation-cache/${fname}
    if cmp -s ${ele} ${dest}; then
      echo is OK
    else
      cp $ele $dest
      copied=1
      echo was copied
    fi
  done
  exit $copied
fi
