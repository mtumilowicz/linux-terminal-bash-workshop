#!/bin/bash

DIR_COUNT=3
FILE_COUNT=3

LOG_RESULT () {
  local COMMAND_DESCRIPTION=$1
  if [[ $? -eq 0 ]]
  then
    echo "Success when $COMMAND_DESCRIPTION"
  else
    echo "Failure when $COMMAND_DESCRIPTION"
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
      LOG_RESULT "running command: $COMMAND"
  done
}

echo "Create workspace"
mkdir workspace
LOG_RESULT "creating Workspace/"

cd workspace

echo "Creating $DIR_COUNT directories"
DO_N_TIMES $DIR_COUNT "CREATE_DIR directory"
LOG_RESULT "creating directories"

echo "Create $FILE_COUNT files per each directory"
for DIR in */
do
  cd $DIR
  DO_N_TIMES $FILE_COUNT "CREATE_FILE file"
  LOG_RESULT "creating files in directory $DIR"
done

LOG_RESULT "creating files in directories"

cd ..

FILES_COUNT=$(find . -mindepth 2 | wc -l)
echo "$(($FILES_COUNT))"

echo "Hiding needle.txt file somewhere"
RANDOM_DIR=$(shuf -i 1-$DIR_COUNT -n 1)
touch touch directory"$RANDOM_DIR"/needle.txt
echo "that's the needle" > needle.txt
cat needle.txt

echo "Moving to the parent parent dir"
find . -type f -name "needle.txt" -exec mv {} .. \;

cd ..
rm -r workspace