#!/usr/bin/env bash
set -u

# color stuff
piss_color="\e[93m"
green_color="\e[32m"
dark_grey_color="\e[90m"
reset_color="\e[0m"

# @param which year
# @param which day
# @param cookie jar location
# @param where to download
# will send user-readable output until ready
download_input() {
  if [[ -r "$4" ]]
  then
    echo 'Skipping...'
    return
  fi
  if ! [[ -r "$3" ]]
  then
    echo "Cookie jar $3 does not exist! Download it!"
    exit 1
  fi
  until curl -fso "$4" -b "$3" --connect-timeout 5 "https://adventofcode.com/$1/day/$2/input"
  do
    echo 'Day not started yet. Hang tight!'
    sleep 1
  done
  echo 'Day has begun.'
}

# @param path to inputs. Should have `input.raw` in it
# sets global "variants" containing variant names mapped to
vary_input() {
  fold -c1 "$1/input.raw" > "$1/input.folded"
  tr $'\n' ' ' < "$1/input.raw" > "$1/input.collapsed"
}

# wrapper of GNU timeout for global config
# @params program command line
xtimeout() {
  timeout 2 "$@"
  if (( $? > 0 ))
  then
    echo 'TIMEOUT'
  fi
}

# Run functions:
# @param folder with user scripts for day
# @params all rest are paths to inputs to try

run_awk() {
  local script_dir=$1
  shift
  if ! [[ -r "$script_dir/solution.awk" ]]
  then
    echo 'No awk script found.'
    return
  fi
  for i in "$@"
  do
    echo -e "${piss_color}AWK $i:${reset_color}"
    xtimeout awk -f "$script_dir/solution.awk" -- "$i"
  done
}

run_perl() {
  # TODO: remove rudandancies
  local script_dir=$1
  shift
  if ! [[ -r "$script_dir/solution.pl" ]]
  then
    echo 'No perl script found.'
    return
  fi
  for i in "$@"
  do
    echo -e "${green_color}Perl $i:${reset_color}"
    xtimeout perl -- "$script_dir/solution.pl" < "$i"
  done
}

if (( $# < 2 ))
then
  echo 'USAGE: helper 2018 24'
  exit 1
fi

tmp_dir="./tmp/$1-$2"
script_dir="./solutions/$1-$2"
mkdir -p "$tmp_dir"

download_input "$1" "$2" ./cookies "$tmp_dir/input.raw"
vary_input "$tmp_dir"
while true
do
  echo -e "${dark_grey_color}-----------------------------------${reset_color}"
  run_awk "$script_dir" "$tmp_dir"/input.*
  run_perl "$script_dir" "$tmp_dir"/input.*
  sleep 1.5
done
