#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

cleanup() {
  cd $project_parent_dir
  if [[ -d workspace ]]
  then
    rm --recursive workspace
  fi
}

trap cleanup 0 EXIT

project_parent_dir=$(pwd)

dir_count=3
file_count=3
script_logging_level="debug"

while getopts ":d:f:l:h" opt; do
  case ${opt} in
    d )
      dir_count=$OPTARG
      ;;
    f )
      file_count=$OPTARG
      ;;
    h )
      echo "Usage:"
      echo "-h                      help"
      echo "-f                      how many files to create per directory"
      echo "-d                      how many directories to create"
      echo "-l                      logging level: debug, error; by default is set debug"
      exit 0
      ;;
    l )
      script_logging_level=$OPTARG
      ;;
    \? )
      echo "use -h option for help"
      exit 1
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

needle_name=${1:-"needle.txt"}

declare -A levels=([debug]=0 [error]=1)

log() {
  local log_priority=$1
  local log_message=$2

  if [[ ${levels[$log_priority]} -gt ${levels[$script_logging_level]} ]]
  then
    echo "${log_priority} : ${log_message}"
  fi
}

log_result () {
  local command_description=$1
  if [[ $? -eq 0 ]]
  then
    log "debug" "success when $command_description"
  else
    log "error" "failure when $command_description"
  fi
}

create_dir() {
  local prefix_name=$1
  local suffix_name=$2
  mkdir $prefix_name$suffix_name
}

create_file() {
  local prefix_name=$1
  local suffix_name=$2
  touch $prefix_name$suffix_name
}

do_n_times() {
  local n=$1
  local command=$2
  for i in $(seq $n); do
      $command $i
      log_result "running command: $command $i"
  done
}

verify_created_file_count() {
  created_file_count=$(find . -type f | wc --lines)
  expected_created_file_count=$(($dir_count * file_count))
  if [[ $created_file_count -eq expected_created_file_count ]]
  then
    log "debug" "number of created files is correct: $expected_created_file_count"
  else
    echo "error" "number of created files is incorrect: $created_file_count and should be: $expected_created_file_count"
  fi
}

log "debug" "create workspace"
mkdir workspace
log_result "creating workspace/"

cd workspace
workspace_dir=$(pwd)

log "debug" "creating $dir_count directories"
do_n_times $dir_count "create_dir directory"
log_result "creating directories"

log "debug" "create $file_count files per each directory"
for dir in */
do
  cd $dir
  do_n_times $file_count "create_file file"
  log_result "creating files in directory $dir"
  cd $workspace_dir
done

log_result "creating files in directories"

verify_created_file_count

log "debug" "hiding needle.txt file somewhere"
random_dir=$(shuf --input-range 1-$dir_count --head-count 1)
touch directory"$random_dir"/$needle_name
log_result "hiding needle"

log "debug" "moving to the parent parent dir"
find . -type f -name $needle_name -exec mv {} .. \;
log_result "moving needle to the workspace/"