#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line
# https://github.com/kvcarido/clouduploader-cli
# - Written by: Kayleen Carido
# - Completed: February 21, 2024


## Checks if AWS CLI is installed
if command -v aws &>/dev/null; then
    PROFILE_PATH="$HOME/.aws/config"
    # If installed, checks if config profile exists 
    if [ -e "$PROFILE_PATH" ]; then
        echo -e "AWS CLI config profile found\n"
        sleep 1
    # Creates new AWS CLI profile
    else
        echo "AWS CLI installed - no config profile found"
        sleep 1
        echo "Create your profile now:"
        sleep 1
        aws configure
        echo "Profile configured - please run command again."
        exit 1
    fi
# Downloads and installs AWS CLI
else
    echo "AWS CLI not found – installing now..."
    sleep 1
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
    sudo installer -pkg ./AWSCLIV2.pkg -target /
    sleep 1
    echo "AWS CLI installed – please run command again."
    exit 1
fi

## Prompts bucket selection
echo -e "Available S3 Buckets:\n"
aws s3 ls
read -r -p "Select a bucket: " BUCKET

## Bucket and file verifications
if aws s3api head-bucket --bucket "$BUCKET" 1>/dev/null 2>/dev/null; then
    echo -e "\n✓ Bucket permissions"
else
    echo "❌ Error – bucket doesn't exist."
    exit 2
fi

if [ -f "$1" ]; then
    echo -e "✓ File (upload) permissions"
else
    echo "❌ Error - file doesn't exist"
    exit 2
fi

## Uploads file to selected bucket
BUCKET_PATH="s3://$BUCKET"
aws s3 cp "$1" "$BUCKET_PATH"