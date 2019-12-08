#!/bin/bash


# Make an associative array in which you'll record pids.
declare -A pids

# Kick off the ELT jobs for SSB and tickit in parallel which issues 1 ETL SQL at a time
psql -f ssb-elt-concurrency.sql &
pid=$!
echo "Backgrounded: 1 (pid=$pid)"
pids[$pid]=1

psql -f tickit-elt-concurrency.sql &
pid=$!
echo "Backgrounded: 2 (pid=$pid)"
pids[$pid]=2

# Kick off the six UNLOAD jobs in parallel to the two ELT jobs above
psql -f tickit-unload1.sql &
pid=$!
echo "Backgrounded: 3 (pid=$pid)"
pids[$pid]=3

psql -f tickit-unload2.sql &
pid=$!
echo "Backgrounded: 4 (pid=$pid)"
pids[$pid]=4

psql -f tickit-unload3.sql &
pid=$!
echo "Backgrounded: 5 (pid=$pid)"
pids[$pid]=5

psql -f ssb-unload1.sql &
pid=$!
echo "Backgrounded: 6 (pid=$pid)"
pids[$pid]=6

psql -f ssb-unload2.sql &
pid=$!
echo "Backgrounded: 7 (pid=$pid)"
pids[$pid]=7

psql -f ssb-unload3.sql &
pid=$!
echo "Backgrounded: 8 (pid=$pid)"
pids[$pid]=8

# Watch your stable of backgrounded processes.
# If a pid goes away, remove it from the array.
while [ -n "${pids[*]}" ]; do
  sleep 10
  for pid in "${!pids[@]}"; do
    if ! ps "$pid" >/dev/null; then
      unset pids[$pid]
      echo "unset: $pid"
    fi
  done
  if [ -z "${!pids[*]}" ]; then
    break
  fi
  printf "\rStill waiting for background jobs: %s ... " "${pids[*]}"
done
