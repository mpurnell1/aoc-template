#!/bin/bash

# Check if a day number was provided as an argument
if [ -z "$1" ]; then
    # If no argument is given, find the latest day number from existing files.
    # It looks for files named like 'day_01_...', extracts the '01', finds the highest number, and adds 1.
    LATEST_DAY=$(ls -d day_??_* 2>/dev/null | sed -n 's/day_\([0-9]\{2\}\)_.*/\1/p' | sort -n | tail -1)

    if [ -z "$LATEST_DAY" ]; then
        # If no day files exist yet, start with Day 1.
        DAY_NUM=1
    else
        # Increment the latest day. The '10#' forces bash to treat the number as base-10.
        DAY_NUM=$((10#$LATEST_DAY + 1))
    fi
else
    # If a day number is provided as an argument, use that.
    DAY_NUM=$1
fi

# Format the day number to always have two digits (e.g., 1 becomes 01).
DAY=$(printf "%02d" $DAY_NUM)

# Define the source filenames (templates)
TEMPLATE_CODE="day_x_puzzle_1_solution.py"
TEMPLATE_INPUT="day_x_input.txt"
TEMPLATE_SAMPLE="day_x_sample_input.txt"

# Create the new filenames replacing 'x' with the provided day number
NEW_CODE="day_${DAY}_puzzle_1_solution.py"
NEW_INPUT="day_${DAY}_input.txt"
NEW_SAMPLE="day_${DAY}_sample_input.txt"

copy_file() {
    local src=$1
    local dest=$2

    if [ ! -f "$src" ]; then
        echo "Error: Template file '$src' not found. Cannot create '$dest'."
        return 1
    fi

    if [ -f "$dest" ]; then
        echo "Warning: File '$dest' already exists. Skipping creation."
        return 0
    fi

    # Copy the template to the new file
    cp "$src" "$dest"

    # Replace 'day_x' with the correct day number (e.g., 'day_08')
    sed -i "s/day_x/day_${DAY}/g" "$dest"

    echo "  Created $dest"
}

echo "Setting up files for Day $DAY..."

copy_file "$TEMPLATE_CODE" "$NEW_CODE"
copy_file "$TEMPLATE_INPUT" "$NEW_INPUT"
copy_file "$TEMPLATE_SAMPLE" "$NEW_SAMPLE"

echo "Setup for Day $DAY complete."
