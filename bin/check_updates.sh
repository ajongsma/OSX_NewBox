#!/usr/bin/env bash

SOURCE="${BASH_SOURCE[0]}"
DIR="$( dirname "$SOURCE" )"
while [ -h "$SOURCE" ]
do
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
  DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

source ../defaults.sh

echo "-----------------------------------------------------------"
echo "| Checking for updates on GIT"
echo "-----------------------------------------------------------"
cd ~/Github/



echo "-----------------------------------------------------------"
echo "| Checking for updates on SVN"
echo "-----------------------------------------------------------"
echo "| Checking for updates NewzNAB:"
#cd /Users/Newznab/Sites/newsnab
#svn info
#svn update
svn info svn://svn.newznab.com/nn/branches/nnplus $INST_NEWZNAB_PATH/

