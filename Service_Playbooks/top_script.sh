#!/bin/bash

# Run the top command and redirect its output to a temporary file
top -b -n 1 > /tmp/top_output

# Parse the "top" output and create a JSON object with individual fields
output=$(tail -n +7 /tmp/top_output | awk '{ printf "{\"PID\":\"%s\",\"USER\":\"%s\",\"PR\":\"%s\",\"NI\":\"%s\",\"VIRT\":\"%s\",\"RES\":\"%s\",\"SHR\":\"%s\",\"S\":\"%s\",\"%%CPU\":%.1f,\"%%MEM\":%.1f,\"TIME+\":\"%s\",\"COMMAND\":\"%s\"}\n", $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12 }')

#awk 'NR>7 {print $12}' /tmp/top_output
# Print the JSON object to stdout (Telegraf will capture this output)
echo "$output"

# Remove the temporary file
rm /tmp/top_output
