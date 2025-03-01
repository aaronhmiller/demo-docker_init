#!/bin/bash

# List of directories to process
DIRECTORIES=(*/);  # This would get all immediate subdirectories in the current directory

for dir in "${DIRECTORIES[@]}"; do
    echo "Processing directory: $dir"
    
    # Change to the directory
    cd "$dir" || { echo "Failed to enter $dir, skipping"; continue; }
    
    # 1. Start docker compose
    echo "Starting docker compose in $dir"
    docker compose up -d --wait
    
    # 2. Make HTTP request to port 8080
    echo "Making HTTP request"
    RESPONSE=$(http :8080 --headers)
    
    # 3. Test for 200 HTTP response code
    if echo "$RESPONSE" | grep -q "HTTP/1.1 200"; then
        echo "SUCCESS: Got HTTP 200 response"
    else
        echo "ERROR: Did not get HTTP 200 response"
        # Optionally add error handling here
    fi
    
    # 4. Shut down docker compose
    echo "Shutting down docker compose in $dir"
    docker compose down
    
    # Return to the original directory
    cd - > /dev/null
    
    echo "Completed processing $dir"
    echo "----------------------------------------"
done

echo "All directories processed"
