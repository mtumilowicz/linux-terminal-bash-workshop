#!/bin/bash

COUNT=3

LOG_RESULT () {
  local COMMAND_RESULT = $1
  local COMMAND_DESCRIPTION = $2
  if [[ COMMAND_RESULT -eq 0 ]]
  then
    echo "Success when $COMMAND_DESCRIPTION"
  else
    echo "Failure when $COMMAND_DESCRIPTION"
  fi
}

echo "Create workspace"
mkdir workspace
if [[ $? -eq 0 ]]
then
  echo "Success when creating Workspace/"
else
  echo "Failure when creating Workspace/"
fi

cd workspace

echo "Creating $COUNT directories"
mkdir directory{1..3}

if [[ $? -eq 0 ]]
then
  echo "Success when creating directories"
else
  echo "Failure when creating directories"
fi


echo "Create $COUNT files per each directory"
for DIR in */
do
  touch "$DIR"/file{1..3}
  if [[ $? -eq 0 ]]
  then
    echo "Success when creating files in directory $DIR"
  else
    echo "Failure when creating files in directories $DIR"
  fi
done

if [[ $? -eq 0 ]]
then
  echo "Success when creating files in directories"
else
  echo "Failure when creating files in directories"
fi

FILES_COUNT=$(find . -mindepth 2 | wc -l)
echo "$(($FILES_COUNT))"

echo "Hiding needle.txt file somewhere"
RANDOM_DIR=$(shuf -i 1-$COUNT -n 1)
touch touch directory"$RANDOM_DIR"/needle.txt
echo "that's the needle" > needle.txt
cat needle.txt

echo "Moving to the parent parent dir"
find . -type f -name "needle.txt" -exec mv {} .. \;

cd ..
rm -r workspace