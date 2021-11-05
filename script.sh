#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

trap CLEANUP 0 EXIT

DIR_COUNT=3
FILE_COUNT=3
PARENT_DIR=$(pwd)
NEEDLE_NAME=needle.txt
script_logging_level="DEBUG"

declare -A levels=([DEBUG]=0 [ERROR]=1)

LOG() {
  local log_priority=$1
  local log_message=$2

  if [[ ${levels[$log_priority]} -gt ${levels[$script_logging_level]} ]]
  then
    echo "${log_priority} : ${log_message}"
  fi
}

LOG_RESULT () {
  local COMMAND_DESCRIPTION=$1
  if [[ $? -eq 0 ]]
  then
    LOG "DEBUG" "Success when $COMMAND_DESCRIPTION"
  else
    LOG "ERROR" "Failure when $COMMAND_DESCRIPTION"
  fi
}

CREATE_DIR() {
  local PREFIX_NAME=$1
  local SUFFIX_NAME=$2
  mkdir $PREFIX_NAME$SUFFIX_NAME
}

CREATE_FILE() {
  local PREFIX_NAME=$1
  local SUFFIX_NAME=$2
  touch $PREFIX_NAME$SUFFIX_NAME
}

DO_N_TIMES() {
  local N=$1
  local COMMAND=$2
  for i in $(seq $N); do
      $COMMAND $i
      LOG_RESULT "running command: $COMMAND $i"
  done
}

VERIFY_CREATED_FILE_COUNT() {
  CREATED_FILE_COUNT=$(find . -type f | wc --lines)
  EXPECTED_CREATED_FILE_COUNT=$(($DIR_COUNT * FILE_COUNT))
  if [[ $CREATED_FILE_COUNT -eq EXPECTED_CREATED_FILE_COUNT ]]
  then
    LOG "DEBUG" "Number of created files is correct: $EXPECTED_CREATED_FILE_COUNT"
  else
    echo "ERROR" "Number of created files is incorrect: $CREATED_FILE_COUNT and should be: $EXPECTED_CREATED_FILE_COUNT"
  fi
}

CLEANUP() {
  cd $PARENT_DIR
  rm -r workspace
}

LOG "DEBUG" "Create workspace"
mkdir workspace
LOG_RESULT "creating Workspace/"

cd workspace

LOG "DEBUG" "Creating $DIR_COUNT directories"
DO_N_TIMES $DIR_COUNT "CREATE_DIR directory"
LOG_RESULT "creating directories"

LOG "DEBUG" "Create $FILE_COUNT files per each directory"
for DIR in */
do
  cd $DIR
  DO_N_TIMES $FILE_COUNT "CREATE_FILE file"
  LOG_RESULT "creating files in directory $DIR"
  cd ..
done

LOG_RESULT "creating files in directories"

VERIFY_CREATED_FILE_COUNT

LOG "DEBUG" "Hiding needle.txt file somewhere"
RANDOM_DIR=$(shuf --input-range 1-$DIR_COUNT --head-count 1)
touch directory"$RANDOM_DIR"/needle.txt
LOG_RESULT "hiding needle"

LOG "DEBUG" "Moving to the parent parent dir"
find . -type f -name "needle.txt" -exec mv {} .. \;
LOG_RESULT "moving needle to the Workspace/"