#!/bin/bash

# Set the threshold percentage for disk usage (e.g., 80%)
THRESHOLD=80

# Get the disk usage for each mounted filesystem
DISK_USAGE=$(df -h | awk 'NR>1 {print $5 " " $1}')

# Iterate through each line of disk usage
while IFS= read -r line; do
  USAGE=$(echo $line | awk '{print $1}' | tr -d '%')
  PARTITION=$(echo $line | awk '{print $2}')

  # Check if the usage exceeds the threshold
  if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "Warning: Partition $PARTITION is ${USAGE}% full."
  fi
done <<< "$DISK_USAGE"

# Optionally, add a summary of the current disk usage
echo "\nCurrent Disk Usage:"
df -h
