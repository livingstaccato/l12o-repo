#!/bin/sh

BUILD_DIR=/build

for spec in ${BUILD_DIR}/SPECS/*.spec; do
  echo ---
  echo
  spectool \
    --define "_topdir ${BUILD_DIR}" \
    --get-files \
    -R ${spec}
  echo
done
