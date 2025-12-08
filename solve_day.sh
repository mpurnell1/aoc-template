#!/bin/bash

# Check if a day number was provided
if [ -z "$1" ]; then
    # If no argument is given, find the latest day number from existing files.
    # It looks for files named like 'day_01_...', extracts the '01', finds the highest number, and adds 1.
    LATEST_DAY=$(ls -d day_??_* 2>/dev/null | sed -n 's/day_\([0-9]\{2\}\)_.*/\1/p' | sort -n | tail -1)

    if [ -z "$LATEST_DAY" ]; then
        echo "Could not infer current day"
        exit 1
    else
	DAY_NUM=$((10#$LATEST_DAY))
    fi
else
    # If a day number is provided as an argument, use that.
    DAY_NUM=$((10#$1))
fi

# Format the day number to always have two digits (e.g., 1 becomes 01).
DAY=$(printf "%02d" $DAY_NUM)

# Define filenames
SOURCE_FILE="day_${DAY}_puzzle_1_solution.py"
DEST_FILE="day_${DAY}_puzzle_2_solution.py"

# Check if the source file exists
if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file '$SOURCE_FILE' does not exist."
    exit 1
fi

# Check if the destination file already exists to prevent accidental overwrite
if [ -f "$DEST_FILE" ]; then
    read -p "Warning: '$DEST_FILE' already exists. Overwrite? (y/N) " response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo "Operation cancelled."
        exit 0
    fi
fi

# Perform the copy
cp "$SOURCE_FILE" "$DEST_FILE"
echo "Created '$DEST_FILE' from '$SOURCE_FILE'"
