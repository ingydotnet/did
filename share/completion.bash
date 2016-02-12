#!bash

# http://stackoverflow.com/questions/7267185/bash-autocompletion-add-description-for-possible-completions

_did() {

    COMPREPLY=()
    local program=did
    local cur=${COMP_WORDS[$COMP_CWORD]}
#    echo "COMP_CWORD:$COMP_CWORD cur:$cur" >>/tmp/comp

    case $COMP_CWORD in

    1)
        _did_compreply '_complete -- Generate self completion'$'\n''build     -- Add Docker ID layers to a '"'"'docker build'"'"' image'$'\n''cmd       -- Print a '"'"'docker run'"'"' command for an entrypoint'$'\n''cmds      -- List all commands (entrypoints) for an image'$'\n''help      -- Show command help'$'\n''id        -- Print Docker ID data for an image to stdout'$'\n''run       -- Run the docker command for an entrypoint'$'\n''search    -- Find existing '"'"'did'"'"' images'

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
      cmd)
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
      cmds)
      ;;
      help)
        case $COMP_CWORD in

        2)
            _did_compreply '_complete '$'\n''build     '$'\n''cmd       '$'\n''cmds      '$'\n''completion'$'\n''id        '$'\n''pod       '$'\n''run       '$'\n''search    '$'\n''validate  '

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
          validate)
          ;;
        esac

        ;;
        esac
      ;;
      id)
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
      run)
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



complete -o default -F _did did

