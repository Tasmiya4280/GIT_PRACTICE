#!/bin/bash

read -p "Enter the user name: " username

echo "You have enterd $username"
sudo useradd  -m $username
echo "successfully created the new user $username"
