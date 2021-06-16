#!/bin/bash

SCRIPT_CALL=$(basename ${0})
SCRIPT_DIR="$( cd "$( dirname "$( readlink -f "${BASH_SOURCE[0]}")")" &> /dev/null && pwd -P )"

tmpl=${1}
newname=${2:-new-${1}}
if [[ -z ${tmpl} || ! -f ${HOME}/Templates/${tmpl} ]] ; then 
  if [[ ! -z ${tmpl} ]]; then 
    echo "***ERROR*** specified template ${tmpl} not found" 
  fi
  CWD=$(pwd)
  cd ${HOME}/Templates
  echo "----"
  echo "Available templates are:" 
  for t in $(find . -type f | sed -n 's|^./||p') ; do 
    echo "  ${SCRIPT_CALL} ${t}"
  done 
  echo "----"
  cd ${CWD}
else
  if [[ -f ${newname} ]] ; then 
    echo "***ERROR*** target file ${newname} already exists" 
    exit 1
  fi
  cp ${HOME}/Templates/${tmpl} ${newname}
  echo "File created at ${newname}" 
fi

echo "Done."
