#!bash

# http://stackoverflow.com/questions/7267185/bash-autocompletion-add-description-for-possible-completions

_did() {

    COMPREPLY=()
    local program=did
    local cur=${COMP_WORDS[$COMP_CWORD]}
#    echo "COMP_CWORD:$COMP_CWORD cur:$cur" >>/tmp/comp

    case $COMP_CWORD in

    1)
        _did_compreply '_complete -- Generate self completion'$'\n''build     -- Add Docker ID layers to a '"'"'docker build'"'"' image'$'\n''cmd       -- Print a '"'"'docker run'"'"' command for an entrypoint'$'\n''cmds      -- List all commands (entrypoints) for an image'$'\n''help      -- Show command help'$'\n''id        -- Print Docker ID data for an image to stdout'$'\n''run       -- Run the docker command for an entrypoint'$'\n''search    -- Find existing '"'"'did'"'"' images'$'\n''shell     -- Open shell'

    ;;
    *)
    # subcmds
    case ${COMP_WORDS[1]} in
      _complete)
        case $COMP_CWORD in
        *)
        case ${COMP_WORDS[$COMP_CWORD-1]} in
          --help|-h)
          ;;
          --name)
          ;;
          --zsh)
          ;;
          --bash)
          ;;

          *)
            _did_compreply "'--help -- Show command help'"$'\n'"'-h     -- Show command help'"$'\n'"'--name -- name of the program'"$'\n'"'--zsh  -- for zsh'"$'\n'"'--bash -- for bash'"
          ;;
        esac
        ;;
        esac
      ;;
      build)
      ;;
      cmd)
        case $COMP_CWORD in
        2)
                _did_cmd_param_id_completion
        ;;
        *)
        case ${COMP_WORDS[$COMP_CWORD-1]} in
          --help|-h)
          ;;

          *)
            _did_compreply "'--help -- Show command help'"$'\n'"'-h     -- Show command help'"
          ;;
        esac
        ;;
        esac
      ;;
      cmds)
        case $COMP_CWORD in
        2)
                _did_cmds_param_id_completion
        ;;
        *)
        case ${COMP_WORDS[$COMP_CWORD-1]} in
          --help|-h)
          ;;

          *)
            _did_compreply "'--help -- Show command help'"$'\n'"'-h     -- Show command help'"
          ;;
        esac
        ;;
        esac
      ;;
      help)
        case $COMP_CWORD in

        2)
            _did_compreply '_complete '$'\n''build     '$'\n''cmd       '$'\n''cmds      '$'\n''completion'$'\n''id        '$'\n''pod       '$'\n''run       '$'\n''search    '$'\n''shell     '$'\n''validate  '

        ;;
        *)
        # subcmds
        case ${COMP_WORDS[2]} in
          _complete)
          ;;
          build)
          ;;
          cmd)
          ;;
          cmds)
          ;;
          completion)
          ;;
          id)
          ;;
          pod)
          ;;
          run)
          ;;
          search)
          ;;
          shell)
          ;;
          validate)
          ;;
        esac

        ;;
        esac
      ;;
      id)
        case $COMP_CWORD in
        2)
                _did_id_param_id_completion
        ;;
        *)
        case ${COMP_WORDS[$COMP_CWORD-1]} in
          --help|-h)
          ;;

          *)
            _did_compreply "'--help -- Show command help'"$'\n'"'-h     -- Show command help'"
          ;;
        esac
        ;;
        esac
      ;;
      run)
        case $COMP_CWORD in
        2)
                _did_run_param_id_completion
        ;;
        *)
        case ${COMP_WORDS[$COMP_CWORD-1]} in
          --help|-h)
          ;;

          *)
            _did_compreply "'--help -- Show command help'"$'\n'"'-h     -- Show command help'"
          ;;
        esac
        ;;
        esac
      ;;
      search)
        case $COMP_CWORD in
        2)
        ;;
        *)
        case ${COMP_WORDS[$COMP_CWORD-1]} in
          --help|-h)
          ;;

          *)
            _did_compreply "'--help -- Show command help'"$'\n'"'-h     -- Show command help'"
          ;;
        esac
        ;;
        esac
      ;;
      shell)
        case $COMP_CWORD in
        2)
                _did_shell_param_id_completion
        ;;
        *)
        case ${COMP_WORDS[$COMP_CWORD-1]} in
          --help|-h)
          ;;
          --bash)
          ;;
          --zsh)
          ;;
          --ash)
          ;;

          *)
            _did_compreply "'--help -- Show command help'"$'\n'"'-h     -- Show command help'"$'\n'"'--bash -- Bash (default)'"$'\n'"'--zsh  -- Zsh'"$'\n'"'--ash  -- Ash'"
          ;;
        esac
        ;;
        esac
      ;;
    esac

    ;;
    esac

}

_did_compreply() {
    IFS=$'\n' COMPREPLY=($(compgen -W "$1" -- ${COMP_WORDS[COMP_CWORD]}))
    if [[ ${#COMPREPLY[*]} -eq 1 ]]; then # Only one completion
        COMPREPLY=( ${COMPREPLY[0]%% -- *} ) # Remove ' -- ' and everything after
        COMPREPLY="$(echo -e "$COMPREPLY" | sed -e 's/[[:space:]]*$//')"
    fi
}

_did_cmd_param_id_completion() {
    local param_id=`docker images -a | cut -d' ' -f1 | grep ^dids/`
    _did_compreply "$param_id"
}
_did_cmds_param_id_completion() {
    local param_id=`docker images -a | cut -d' ' -f1 | grep ^dids/`
    _did_compreply "$param_id"
}
_did_id_param_id_completion() {
    local param_id=`docker images -a | cut -d' ' -f1 | grep ^dids/`
    _did_compreply "$param_id"
}
_did_run_param_id_completion() {
    local param_id=`docker images -a | cut -d' ' -f1 | grep ^dids/`
    _did_compreply "$param_id"
}
_did_shell_param_id_completion() {
    local param_id=`docker images -a | cut -d' ' -f1 | grep ^dids/`
    _did_compreply "$param_id"
}


complete -o default -F _did did

