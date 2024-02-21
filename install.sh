#!/bin/bash

# makes script executable 

# variables
SCRIPT_NAME="cloud-uploader.sh"
DEST="$PATH"

# copy the script file to the destination /usr/bin
cp "$SCRIPT_NAME" "$DEST"

# check if copy is successful
if [ $? -eq 0 ]; then
    echo "Script $SCRIPT_NAME successfully installed to $DEST"
else
    echo "Script $SCRIPT_NAME  failed to install to $DEST"
fi