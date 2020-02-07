#!/bin/sh

set -e

if [ -z "$AWS_S3_BUCKET" ]; then
  echo "AWS_S3_BUCKET is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ]; then
  echo "AWS_ACCESS_KEY_ID is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "AWS_SECRET_ACCESS_KEY is not set. Quitting."
  exit 1
fi

if [ -z "$AWS_DEFAULT_REGION" ]; then
  echo "AWS_DEFAULT_REGION is not set. Quitting."
  exit 1
fi

if [ -z "$SOURCE_DIR" ]; then
  echo "SOURCE_DIR is not set. Quitting."
  exit 1
fi


mkdir -p ~/.aws
touch ~/.aws/credentials

echo "Change directory to Source"
cd $SOURCE_DIR

echo "Run npx"
npx webpack --mode development

echo "[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}" > ~/.aws/credentials
 
if [ -d "$SOURCE_DIR" ]; then
    echo "Copying to website folder"
    aws s3 sync ${SOURCE_DIR} s3://${AWS_S3_BUCKET} --exact-timestamps --delete --region ${AWS_DEFAULT_REGION} $*
fi

echo "Cleaning up things"

rm -rf ~/.aws
