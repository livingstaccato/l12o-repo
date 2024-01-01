#!/bin/bash

directory="$1"
index_file="$directory/index.html"

source "$(dirname "$0")/_l12o_generate_index_header.sh"
source "$(dirname "$0")/_l12o_generate_index_row.sh"
source "$(dirname "$0")/_l12o_generate_index_footer.sh"


echo "Creating an index for: ${directory}"

generate_header "$directory" > "$index_file"

# Include . (current directory)
generate_row "." "Directory" "" "" >> "$index_file"
generate_row ".." "Directory" "" "" >> "$index_file"

for item in "$directory"/*; do
  if [ "$item" != "$index_file" ]; then

    filename=$(basename "$item")

    if [ -d "$item" ]; then
      item_type="Directory"
    else
      item_type="File"
    fi

    item_size=$(du -sb "$item" | cut -f1)

    item_modified=$(date -r "$item" "+%Y-%m-%d %H:%M:%S")
    echo "Adding: ${item}"

    generate_row "$filename" "$item_type" "$item_size" "$item_modified" >> "$index_file"

  fi
done

generate_footer >> "$index_file"
