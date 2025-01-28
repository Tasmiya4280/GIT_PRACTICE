#!/bin/bash

read -p "Enter the user name: " username

echo "You have enterd $username"
sudo userdel $username
echo "successfully deleted the user $username"
