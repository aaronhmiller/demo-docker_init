#!/bin/bash
# Create a log file with timestamp
LOG_FILE="webapp_testing_$(date +%Y%m%d_%H%M%S).log"
echo "Starting testing at $(date)" > "$LOG_FILE"

# Initialize counters
SUCCESS_COUNT=0
ERROR_COUNT=0

# List of directories to process
DIRECTORIES=(*/); # This would get all immediate subdirectories in the current directory

for dir in "${DIRECTORIES[@]}"; do
  echo "Testing project in: $dir" | tee -a "$LOG_FILE"
  cd "$dir" # note that ../$LOG_FILE needed now
  
  # 1. Start docker compose
  echo "Starting docker compose in $dir" | tee -a "../$LOG_FILE"
  docker compose up -d --wait # 2>&1 | tee -a "../$LOG_FILE"
  
  # 2. Make HTTP request to port 8080
  echo "Making HTTP request" | tee -a "../$LOG_FILE"
  RESPONSE=$(http :8080 --headers 2>&1)
  #echo "$RESPONSE" >> "../$LOG_FILE"
  
  # 3. Test for 200 HTTP response code
  if echo "$RESPONSE" | grep -q "HTTP/1.1 200"; then
    echo "SUCCESS: Got HTTP 200 response" | tee -a "../$LOG_FILE"
    ((SUCCESS_COUNT++))
  else
    echo "ERROR: Did not get HTTP 200 response" | tee -a "../$LOG_FILE"
    ((ERROR_COUNT++))
    # Optionally add error handling here
  fi
  
  # 4. Shut down docker compose
  echo "Shutting down docker compose in $dir" | tee -a "../$LOG_FILE"
  docker compose down #2>&1 | tee -a "../$LOG_FILE"
  
  # Return to the original directory
  cd - > /dev/null
  echo "Completed testing of $dir" | tee -a "$LOG_FILE"
  echo "----------------------------------------" | tee -a "$LOG_FILE"
done

# Add summary to output and log file
echo "SUMMARY:" | tee -a "$LOG_FILE"
echo "   SUCCESSES: $SUCCESS_COUNT" | tee -a "$LOG_FILE"
echo "   ERRORS: $ERROR_COUNT" | tee -a "$LOG_FILE"
echo "   TOTALS: $((SUCCESS_COUNT + ERROR_COUNT))" | tee -a "$LOG_FILE"
echo "----------------------------------------" | tee -a "$LOG_FILE"

echo "All projects tested" | tee -a "$LOG_FILE"
echo "Log file created: $LOG_FILE"
# echo "Cleaning up images..."
# docker rmi $(docker images -q)
