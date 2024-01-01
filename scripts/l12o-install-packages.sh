#!/bin/bash

for pkg_list in /pkgs/*.list; do
  echo "Installing ${pkg_list} package list"
  xargs dnf -y install <${pkg_list}
done
