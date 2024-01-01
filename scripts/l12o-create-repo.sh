#!/bin/bash

#set -xeuo pipefail

# We need some OS-related info.
source /etc/os-release

os_id=${ID}
os_ver=${VERSION}
os_arch=${HOSTTYPE}

# Define source and destination directories
repo_base="/repo/rpm/${os_id}/${os_ver}"

host_rpm_dir="/rpms"
host_srpm_dir="/srpms"

mkdir -p ${repo_base}/{${os_arch},source}

#  Create RPM repository directories for each architecture
for repo in {${host_rpm_dir},${host_srpm_dir}}; do
    echo "initializing repo dir: ${repo}"

    for char in {0..9} {a..z}; do
        if [ "${repo}" == "${host_srpm_dir}" ]; then
            mkdir -p "${repo_base}/srpms/${char}"
        else
            mkdir -p "${repo_base}/${os_arch}/${char}"
        fi
    done

    # Move RPM/SRPM files to their respective directories
    find "${repo}" -name '*.rpm' -exec sh -c '
        file="${0}"

        char=$(basename "${file}" | head -c 1)

        if [[ "${file}" =~ "'"${host_srpm_dir}"'" ]]; then
            dest_dir="'"${repo_base}"'/srpms/${char}"
        else
            dest_dir="'"${repo_base}"'/'"${os_arch}"'/${char}"
        fi

        mkdir -p "${dest_dir}"

        cp -v "${file}" "${dest_dir}"
    ' {} "${repo}" \;
    echo

done

#!/bin/bash

# there's a better way to do this. til now imma just collapse this shit
# then loop through any bundles.

for repo in {${os_arch},bundles/**/${os_arch}}; do

  printf '\n*******\n*** %s\n*******\n' ${repo}

  repo_dir="${repo_base}/${repo}" 

  printf "${repo_dir}\n\n"

  if [[ -d ${repo_base}/${repo} ]]; then

    cp /rpms/noarch/* /rpms/${repo}

    createrepo_c \
      --pretty \
      --update /${repo_base}/${repo}

  else
    printf 'aint nuttin to do here.\n'
  fi

done

printf '\n\n+++++++\n+++ srpms\n+++++++\n'
createrepo_c \
  --pretty \
  --update /${repo_base}/srpms
