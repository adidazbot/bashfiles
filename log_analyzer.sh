#!/bin/bash

logfile="/path/to/logfile.log"
error_pattern="ERROR"  # Adjust pattern as needed

# Extract error lines and count occurrences
error_lines=$(grep -E "$error_pattern" "$logfile" | wc -l)

if [ $error_lines -gt 0 ]; then
  echo "Found $error_lines errors in $logfile"
  grep -E "$error_pattern" "$logfile" > error_log.txt
  echo "Error log created: error_log.txt"
else
  echo "No errors found in $logfile"
fi
