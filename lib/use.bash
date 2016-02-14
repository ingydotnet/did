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
  [[ -n $DID_ROOT ]] || die "Set DID_ROOT"
  "$DID_ROOT/sbin/yaml2bash" "$@"
}

yaml2json() {
  docker run -i dids/yaml2json "$@"
}

normalize-did-name() {
  if [[ ! $did_name =~ / ]]; then
    did_name="dids/$did_name"
  elif [[ $did_name =~ ^\./ ]]; then
    did_name="${did_name#./}"
  fi
}
