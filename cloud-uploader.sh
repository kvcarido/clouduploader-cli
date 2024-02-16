#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line

aws_config () {
    if command -v aws &>/dev/null; then
        profile_path="$HOME/.aws/config"
        # if AWS CLI installed, check if config profile exists 
        if [ -e "$profile_path" ]; then
            echo "AWS CLI config profile found"
            sleep 1
            echo "Session started"
            echo ""
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
    echo "Available S3 Buckets:"
    aws s3 ls
    echo ""
    sleep 2
}

confirm_bucket () {
    read -r -p "Select a bucket: " bucket

    # write conditional checking if bucket name exists
}

aws_config
s3_list_buckets
confirm_bucket
# confirm successful upload, list items in buckets