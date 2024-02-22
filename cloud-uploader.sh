#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line
# GitHub link
# - Written by: Kayleen Carido
# - Completed: February 21, 2024

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

upload_file () {
    # prompts user for bucket and file
    read -r -p "Select a bucket: " BUCKET
    read -r -p "File to upload: " FILE_TO_UPLOAD

    # Verifies if bucket exists
    if aws s3api head-bucket --bucket "$BUCKET" 1>/dev/null 2>/dev/null; then
        echo -e "\nUploading...\n"
        BUCKET_PATH="s3://$BUCKET"
        aws s3 cp "$FILE_TO_UPLOAD" "$BUCKET_PATH"
    else
        echo "Error – bucket name $BUCKET doesn't exist."
    fi
}

##### SCRIPT #####
welcome_msg
s3_list_buckets
upload_file
