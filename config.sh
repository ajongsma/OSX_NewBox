#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

#Copy this file to defaults.sh
#DO NOT EDIT THIS FILE, BUT EDIT DEFAULTS.SH INSTEAD

##############################################################
######################### EDIT THESE #########################
##############################################################

## Full User Name for GIT
export INST_GIT_FULL_NAME='Andries Jongsma'

## E-mail address for GIT
export INST_GIT_EMAIL='a.jongsma@gmail.com'

############################################################

## NewzNAB paths
export $INST_NEWZNAB_PATH="/Users/Newznab/Sites/newznab"

##Should not need to change
export INST_NEWZNAB_UPDATE_PATH=$NEWZNAB_PATH"/misc/update_scripts"
export INST_NEWZNAB_TESTING_PATH=$NEWZNAB_PATH"/misc/testing"
export INST_NEWZNAB_ADMIN_PATH=$NEWZNAB_PATH"/www/admin"

############################################################

## By using this script you understand that the programmer is not responsible for any loss of data, users, or sanity.
## You also agree that you were smart enough to make a backup of your database and files. Do you agree? yes/no
export AGREED="no"

############################################################

##END OF EDITS##