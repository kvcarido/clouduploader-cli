#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line
# - Written by: Kayleen Carido
# - Completed: [date]

FILE_TO_UPLOAD="$1"

welcome_msg () {
    echo  "--------- AWS Cloud Uploader ---------"
    echo  "Important:"
    echo -e "You must be in the working directory\n of the file you want to upload!"
    echo -e "--------------------------------------\n"
    sleep 2
}

s3_list_buckets () {
    echo -e "Available S3 Buckets:\n"
    aws s3 ls
    echo ""
}

verify_bucket () {
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
welcome_msg
s3_list_buckets
# verify_bucket
# upload_file
# confirm successful upload, list items in buckets
###########################