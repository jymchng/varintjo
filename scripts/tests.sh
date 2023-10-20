#!/bin/bash

mojo_directory="src"
original_dir=$(pwd)  # Store the original directory

find "$mojo_directory" -type f -name '*.mojo' | while IFS= read -r mojo_file; do
    mojo_dir=$(dirname "$mojo_file")
    file_name=$(basename "$mojo_file")
    cd "$mojo_dir" || exit 1
    mojo "$file_name"
    cd "$original_dir"  # Return to the original directory
done