#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line

# Checks if AWS CLI is installed, asks user to authenticate
aws_config () {
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /
    echo "Please sign in to AWS CLI"
    sleep 2
    aws configure
}

# aws_config