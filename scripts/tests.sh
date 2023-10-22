#!/bin/bash

mojo_directory="src"
original_dir=$(pwd)  # Store the original directory

find "$mojo_directory" -type f -name '*.mojo' | while IFS= read -r mojo_file; do
    # Extract the filename without the path
    file_name=$(basename "$mojo_file")
    
    # Check if the filename is not "__init__.mojo"
    if [ "$file_name" != "__init__.mojo" ]; then
        mojo_dir=$(dirname "$mojo_file")
        cd "$mojo_dir" || exit 1
        mojo "$file_name"
        cd "$original_dir"  # Return to the original directory
    fi
done