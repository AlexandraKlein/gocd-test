#!/bin/bash

# http://stackoverflow.com/questions/12451278/bash-capture-stdout-to-a-variable-but-still-display-it-in-the-console
exec 5>&1

get_full_path() {
  echo "$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"
}

coloredEcho () {
    local exp=$1;
    local color=$2;
    if ! [[ $color =~ '^[0-9]$' ]] ; then
       case $(echo $color | tr '[:upper:]' '[:lower:]') in
        black) color=0 ;;
        red) color=1 ;;
        green) color=2 ;;
        yellow) color=3 ;;
        blue) color=4 ;;
        magenta) color=5 ;;
        cyan) color=6 ;;
        white|*) color=7 ;; # white or invalid color
       esac
    fi
    tput setaf $color;
    echo $exp;
    tput sgr0;
}

exit_on_error () {
    if [ ${1} != 0 ]; then
        coloredEcho "${2}" red
        exit ${1}
    fi
}

return_on_error () {
    if [ ${1} != 0 ]; then
        coloredEcho "${2}" red
        return ${1}
    fi
}

confirm () {
    # call with a prompt string or use a default
    read -n 1 -r -p "${1:-Are you sure? [y/N]} " response
    echo    # move to a new line
    case $response in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}
