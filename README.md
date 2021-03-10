# Israel Hiking Map Graphopper router using Docker

## Installation

- Install Docker
- Clone this repository

## Activation

Run `docker-compose up -d`


## Updating the routing data

For quick activation, the server will initially use historic routing data.
To use up-to-date routing data, run `./gh-update.sh` on Linux or `gh-update.bat` on Windows.

The scripts are identical (hard linked) and perform the following tasks:
  - Download new OSM data if needed
  - Calculate new routing data
  - Start or restart the Graphhopper server, as appropriate, with the new routing data

The scripts can also be run periodically or after changeing the `gh-config.yml` file.
