#!/bin/bash

# Function to read input if not provided as arguments
read_input() {
  if [ -z "$USER_NAME" ]; then
    read -p "Enter the username: " USER_NAME
  fi
  if [ -z "$PUBLIC_KEY" ]; then
    read -p "Enter the public SSH key: " PUBLIC_KEY
  fi
}

# Check if the correct number of arguments is provided
if [ "$#" -eq 2 ]; then
  USER_NAME="$1"
  PUBLIC_KEY="$2"
else
  read_input
fi

# Variables
SSH_DIR="/home/$USER_NAME/.ssh"
AUTH_KEYS="$SSH_DIR/authorized_keys"

# Create new user
sudo useradd -m -s /bin/bash $USER_NAME

# Create .ssh directory if it doesn't exist
sudo mkdir -p $SSH_DIR

# Set correct permissions for .ssh directory
sudo chmod 700 $SSH_DIR
sudo chown $USER_NAME:$USER_NAME $SSH_DIR

# Add the public key to authorized_keys
echo "$PUBLIC_KEY" | sudo tee $AUTH_KEYS > /dev/null
sudo chmod 600 $AUTH_KEYS
sudo chown $USER_NAME:$USER_NAME $AUTH_KEYS

echo "User $USER_NAME created and SSH key installed."
