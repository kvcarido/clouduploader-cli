#!/bin/bash

# Script that uploads a file to an AWS S3 bucket from the command line
# - Written by: Kayleen Carido
# - Completed: [date]

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
            echo "AWS CLI installed - no config profile found"
            sleep 1
            echo "create your profile now:"
            sleep 1
            aws configure
        fi
    # downloads and installs AWS CLI
    else
        echo "AWS CLI not found – installing now..."
        sleep 1
        curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
        sudo installer -pkg ./AWSCLIV2.pkg -target /
        sleep 1
        echo "AWS CLI installed – please run command again."
    fi
}

##############
### SCRIPT ###
##############
aws_config
##############