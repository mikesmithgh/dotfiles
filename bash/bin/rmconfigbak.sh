#!/bin/bash

# directory logic copied from http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in

# -- start stack overflow
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
# -- end stack overflow

bashDir=$(dirname $DIR)

# bash files
declare -a bashFiles=(
  ".bash_colors"
  ".bash_completion"
  ".bash_functions"
  ".bash_profile"
  ".bashrc"
)

# backup and copy files
for i in "${bashFiles[@]}" ; do
  rmCommand="${HOME}/${i}.bak-*"
  rm ${rmCommand}
done