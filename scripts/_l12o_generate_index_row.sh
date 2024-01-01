#!/bin/bash

function generate_row() {
  filename="$1"
  item_type="$2"
  item_size="$3"
  item_modified="$4"
  
  cat <<EOF
        <tr>
          <td><a href="$filename">$filename</a></td>
          <td>$item_size</td>
          <td>$item_modified</td>
        </tr>
EOF
}
