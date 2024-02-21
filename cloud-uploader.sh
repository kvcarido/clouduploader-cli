#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line

aws_config () {
    if command -v aws &>/dev/null; then
        profile_path="$HOME/.aws/config"
        # if AWS CLI installed, check if config profile exists 
        if [ -e "$profile_path" ]; then
            echo "AWS CLI config profile found"
            sleep 1
            echo -e "Session started\n"
            sleep 1
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
    read -r -p "Select a bucket: " bucket
    confirm_bucket "$bucket"
}

confirm_bucket () {
    # local bucket_name="$1"
    bucketstatus=$(aws s3api head-bucket --bucket "$1" 2>&1)
    if echo "${bucketstatus}" | grep 'Not Found';
    then
    echo "Bucket doesn't exist";
    elif echo "${bucketstatus}" | grep 'Forbidden';
    then
    echo "Bucket exists but not owned"
    elif echo "${bucketstatus}" | grep 'Bad Request';
    then
    echo "Bucket name specified is less than 3 or greater than 63 characters"
    else
    echo "Bucket owned and exists";
    fi
}

aws_config
s3_list_buckets
# confirm successful upload, list items in buckets