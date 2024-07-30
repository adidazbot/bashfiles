#!/bin/bash

backup_dir="/path/to/backup"
source_dir="/path/to/source"
backup_file="${backup_dir}/backup_$(date +%Y%m%d_%H%M%S).tar.gz"

if [ ! -d "$backup_dir" ]; then
  mkdir -p "$backup_dir"
fi

tar -czf "$backup_file" "$source_dir" || {
  echo "Backup failed: $backup_file"
  exit 1
}

echo "Backup created: $backup_file"

#adidazbot


