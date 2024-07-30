#!/bin/bash

# Function to check CPU usage and send notifications
check_cpu_usage() {
  threshold_critical=90
  threshold_warning=80

  # Use sar or vmstat for more accurate data
  cpu_usage=$(sar -u 1 1 | tail -n 1 | awk '{print $4}')

  if [ "$cpu_usage" -ge "$threshold_critical" ]; then
    echo "Critical CPU usage: $cpu_usage%"
    # Send critical notification (e.g., email, Slack)
  elif [ "$cpu_usage" -ge "$threshold_warning" ]; then
    echo "Warning: High CPU usage: $cpu_usage%"
    # Send warning notification (e.g., email, Slack)
  fi
}

# Call the function every 5 minutes (adjust as needed)
while true; do
  check_cpu_usage
  sleep 300
done
