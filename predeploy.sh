#!/bin/bash

while getopts ":pst:" opt; do
  case $opt in
    p)
      echo "-p was triggered, Parameter: $OPTARG" >&2
      PASS=$OPTARG
      ;;
    s)
      SITE=$OPTARG
      ;;
    t)
      PASS=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

echo "Checking live theme updates..."
theme download -p=$PASS -s=$SITE -t=$THEME
if [ -z "$(git status --porcelain)" ]; then
  echo "No new changes have been made to the live theme, proceeding with deployment."
  exit 0;
else
  echo "Deployment failed. Changes have been made to the live theme, please download the latest changes and redeploy."
  set -e; exit 1;
fi