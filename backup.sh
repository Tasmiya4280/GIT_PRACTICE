#!/bin/bash

function display_usage {
  echo "usage: ./backup.sh <path to the source file> <path to the destination folder>"
}

if [ $# -eq 0 ]; then
   display_usage
   exit 1
fi

sourcefile="$1"
timestamp=$( date '+%Y-%m-%d-%H-%M-%S' )
destination_folder="$2"

function create_backup {
    zip -r "${destination_folder}/backup_${timestamp}.zip" "${sourcefile}" > /dev/null
    if [ $? -eq 0 ]; then
        echo "Backup generated successfully for ${timestamp}"
    else
        echo "Backup failed!"
        exit 1
    fi
}

function perform_rotation {
    echo "Checking for backups in: ${destination_folder}"
    backups=($(ls -t "${destination_folder}"/backup_*.zip 2>/dev/null))

    echo "Found backups: ${#backups[@]}"
    if [ "${#backups[@]}" -gt 5 ]; then
        echo "Performing rotation: Keeping the 5 most recent backups."
        backups_to_remove=("${backups[@]:5}") 
        echo "Backups to remove: ${backups_to_remove[@]}"

        for backup in "${backups_to_remove[@]}"; do
            echo "Removing old backup: ${backup}"
            rm -f "${backup}"
        done
        echo "Rotation completed."
    else
        echo "No rotation needed. Total backups: ${#backups[@]}"
    fi
}

create_backup
perform_rotation

