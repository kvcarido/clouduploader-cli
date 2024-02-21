#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line
# - Written by: Kayleen Carido
# - Completed: [date]
FILE_TO_UPLOAD="$1"

aws_config () {
    # checks if AWS CLI is installed
    if command -v aws &>/dev/null; then
        PROFILE_PATH="$HOME/.aws/config"
        # if installed, checks if config profile exists 
        if [ -e "$PROFILE_PATH" ]; then
            echo "AWS CLI config profile found"
            sleep 1
            echo -e "Session started\n"
            sleep 1
        # creates new AWS CLI profile
        else
            aws_set_profile
        fi
    else
        # downloads and installs AWS CLI
        echo "AWS CLI not found – installing now..."
        sleep 1
        curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
        sudo installer -pkg ./AWSCLIV2.pkg -target /
        sleep 1
        echo "AWS CLI installed – please run command again."
    fi
}

aws_set_profile () {
    echo "AWS CLI installed - no config profile found"
    sleep 1
    echo "create your profile now:"
    sleep 1
    aws configure
}

s3_list_buckets () {
    echo -e "Available S3 Buckets:\n"
    aws s3 ls
    sleep 1
}

confirm_bucket () {
    # prompts user for bucket name
    read -r -p "Select a bucket: " BUCKET

    # check if $BUCKET exists
    BUCKET_STATUS=$(aws s3api head-bucket --bucket "$BUCKET" 2>&1)
    if echo "${BUCKET_STATUS}" | grep 'Not Found';
    then
    echo "Bucket doesn't exist";
    elif echo "${BUCKET_STATUS}" | grep 'Forbidden';
    then
    echo "Bucket exists but not owned"
    elif echo "${BUCKET_STATUS}" | grep 'Bad Request';
    then
    echo "Bucket name specified is less than 3 or greater than 63 characters"
    else
    echo "Bucket owned and exists";
    fi
}

upload_file () {
    # Uploads file
    BUCKET_PATH="s3://aok-demo-bucket"
    aws s3 cp "$FILE_TO_UPLOAD" "$BUCKET_PATH"
}

###########################
##### SCRIPT EXECUTES #####
###########################
#aws_config
#s3_list_buckets
#confirm_bucket
upload_file
# confirm successful upload, list items in buckets
###########################