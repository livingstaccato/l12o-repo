#!/bin/bash

# Enable debug mode
# Get the Git repository path as the first argument
repo_path="${1}"

if [ ! -d "${repo_path}/.git" ]; then
  echo "The repo path does not exist or has no .git directory."
  exit 1
fi

# Define the target MD5 checksums as the remaining arguments
target_md5sums=("${@:2}") # Use all arguments except the first one

# Define output formats
output_csv="output.csv"
output_json="output.json"

# Initialize the CSV file with header
echo "file,md5sum,git_commit_id" > "$output_csv"

# Initialize an empty JSON array
echo "[]" > "$output_json"

# Change to the Git repository directory
cd "${repo_path}" || exit 1

# Iterate through files in the repository
for target_md5sum in "${target_md5sums[@]}"; do
    # Iterate through all commits in the repository
    git rev-list --all | while read -r commit_id; do
        # Get the file list for the current commit
        file_list=$(git ls-tree --full-tree -r "${commit_id}" | awk '{ print $4 }')

        # Iterate through files in the current commit
        for file in ${file_list}; do
            # Compute the MD5 checksum for the current file
            file_md5sum=$(git show "${commit_id}:${file}" | md5sum | awk '{ print $1 }')

            # Check if the MD5 checksum matches the target
            if [ "${file_md5sum}" == "${target_md5sum}" ]; then
                # Print the CSV row
                echo "${file},${target_md5sum},${commit_id}" >> "$output_csv"

                # Create JSON object and append it to the JSON file
                json_object=$(jq -n --arg file "$file" --arg md5sum "$target_md5sum" --arg commit_id "$commit_id" '{file: $file, md5sum: $md5sum, commit_id: $commit_id}')
                jq ". += [$json_object]" "$output_json" > tmp.json && mv tmp.json "$output_json"
            fi
        done
    done
done

# Validate the JSON
jq . "$output_json" >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "Generated JSON is not valid."
else
  echo "Generated JSON is valid."
fi


echo "CSV output saved to: $output_csv"
echo "JSON output saved to: $output_json"
