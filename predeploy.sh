#!/bin/bash

echo "Checking live theme updates..."
theme download -p=$MAIN_SHOPIFY_PASSWORD -s=$MAIN_SHOPIFY_STORE_URL -t=$MAIN_SHOPIFY_THEME_ID
if [ -z "$(git status --porcelain)" ]; then
  echo "No new changes have been made to the live theme, proceeding with deployment."
  exit 0;
else
  echo "Deployment failed. Changes have been made to the live theme, please download the latest changes and redeploy."
  set -e; exit 1;
fi