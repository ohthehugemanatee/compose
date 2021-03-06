#!/usr/bin/env bats

load common

@test "Test tree setup" {
  export DORK_PLUGINS="env:lib:tree:proxy"

  cd $SOURCES/tree/one
  dork-compose up -d
  cd $SOURCES/tree/two
  dork-compose up -d

  # Sleep to wait for the container to boot.
  sleep 1

  # Test if the container is accessible.
  get tree--one.dork index.html | grep '<h1>Testpage 1</h1>'

  # Test if the container is accessible.
  get tree--two.dork index.html | grep '<h1>Testpage 2</h1>'

  cd $SOURCES/tree/one
  dork-compose down -v --rmi local
  cd $SOURCES/tree/two
  dork-compose down -v --rmi local
}