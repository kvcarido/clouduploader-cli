#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line
# GitHub link
# - Written by: Kayleen Carido
# - Completed: February 21, 2024

# Checks if script is executable
SCRIPT_PATH=$(/usr/local/bin/cloud-uploader.sh)

if [ -e "$SCRIPT_PATH" ]; then
    echo "Script is executable."
else
    echo "No script found."
    sleep 2
    cp ./cloud-uploader.sh /usr/local/bin/
    echo "Settings updated, script now executable."
fi

aws_config () {
    # Checks if AWS CLI is installed
    if command -v aws &>/dev/null; then
        PROFILE_PATH="$HOME/.aws/config"
        # If installed, checks if config profile exists 
        if [ -e "$PROFILE_PATH" ]; then
            echo -e "AWS CLI config profile found\n"
            sleep 1
            echo "To upload, type 'cloud-uploader.sh' in the terminal"
            sleep 1
        # Creates new AWS CLI profile
        else
            echo "AWS CLI installed - no config profile found"
            sleep 1
            echo "create your profile now:"
            sleep 1
            aws configure
        fi
    # Downloads and installs AWS CLI
    else
        echo "AWS CLI not found – installing now..."
        sleep 1
        curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
        sudo installer -pkg ./AWSCLIV2.pkg -target /
        sleep 1
        echo "AWS CLI installed – please run command again."
    fi
}