#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line

# Checks if AWS CLI is installed, asks user to authenticate
aws_config () {
    if command -v aws &>/dev/null; then
        aws configure
    else
        echo "AWS CLI not found – installing now..."
        sleep 2
        curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
        sudo installer -pkg ./AWSCLIV2.pkg -target /
        sleep 2
        echo "AWS CLI installed – please run command again."
    fi
}

aws_config