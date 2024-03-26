#!/bin/bash

# Default values
PROJECT_DIR=""
FILES_LIST="files.txt"
OUTPUT_PATHS="file_paths.txt"

# Usage message
usage() {
    echo "Usage: $0 -d PROJECT_DIR [-f FILES_LIST] [-o OUTPUT_PATHS]"
    echo "  -d PROJECT_DIR     The directory to search for SQL files. (Compulsory)"
    echo "  -f FILES_LIST      The file containing the list of .sql files. Default is 'files.txt'."
    echo "  -o OUTPUT_PATHS    The output file for the paths. Default is 'file_paths.txt'."
    exit 1
}

# Parse command line options
while getopts "d:f:o:" opt; do
    case $opt in
        d) PROJECT_DIR=$OPTARG ;;
        f) FILES_LIST=$OPTARG ;;
        o) OUTPUT_PATHS=$OPTARG ;;
        *) usage ;;
    esac
done

# Check if PROJECT_DIR was provided
if [ -z "$PROJECT_DIR" ]; then
    echo "Error: PROJECT_DIR is required."
    usage
fi

# Ensure PROJECT_DIR does not end with a slash
PROJECT_DIR="${PROJECT_DIR%/}"

# Empty or create the file to store the results
> "$OUTPUT_PATHS"

# Read each file name from FILES_LIST and search for it in PROJECT_DIR
while IFS= read -r file_name; do
    # Use find to locate the file, check if found, else report not found
    file_path=$(find "$PROJECT_DIR" -type f -name "$file_name")
    if [ -z "$file_path" ]; then
        echo "***** FILE NOT FOUND: $file_name" >> "$OUTPUT_PATHS"
    else
        echo "$file_path" >> "$OUTPUT_PATHS"
    fi
done < "$FILES_LIST"

echo "Search completed. Paths stored in $OUTPUT_PATHS."
