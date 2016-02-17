#!/usr/bin/env bash

set -e

export PATH="$(
  remote_libs=()
  if [[ $0 =~ \.remote-script$ ]]; then
    remote_libs=(
      $(dirname $BASH_SOURCE)
      $(dirname $BASH_SOURCE)/bashplus/{bin,lib}
    )
  fi

  local_libs=($(
    cd $(dirname $BASH_SOURCE)
    if [[ $0 =~ \.remote-script$ ]]; then
      echo $PWD
      echo $PWD/*/{bin,lib}
    else
      cd $(git rev-parse --show-toplevel)
      echo $PWD/lib
      echo $PWD/ext/*/{bin,lib}
    fi
  ))

  set -- ${remote_libs[@]} ${local_libs[@]}
  IFS=:; echo "$*"
):$PATH"

source bash+ :std can

error() {
  echo "Error: $@" >&2
  exit 1
}

yaml2bash() {
  docker run --rm --interactive --entrypoint /yaml2bash dids/did-tools "$@"
}

yaml2json() {
  docker run --rm --interactive --entrypoint /yaml2json dids/yaml2json "$@"
}

normalize-did-name() {
  did_cmd=main
  if [[ $did_name =~ =(.*) ]]; then
    did_cmd="${BASH_REMATCH[1]}"
    [[ ! $did_cmd =~ ^[[:word:]]+$ ]] ||
      error "Invalid did command: '$did_cmd'."
    did_name="${did_name%=*}"
  fi

  if [[ ! $did_name =~ / ]]; then
    did_name="dids/$did_name"
  elif [[ $did_name =~ ^\./ ]]; then
    did_name="${did_name#./}"
  fi
}
