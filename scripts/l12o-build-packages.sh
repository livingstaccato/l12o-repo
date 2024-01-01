#!/bin/bash

#set -euo pipefail
set -o pipefail

LOG_DIR=/logs/$(date '+%Y%m%d-%H%M%S')

REPO_DIR=/repo/rpm/amzn/2023

PACKAGE_DIR=${REPO_DIR}/${HOSTTYPE}

SRC_DIR=${REPO_DIR}/source

SRPMS_DIR=${REPO_DIR}/srpms

BUILD_DIR=/build

mkdir -p ${LOG_DIR} ${BUILD_DIR}/{BUILD,BUILDROOT,RPMS,SOURCES,SPECS,SRPMS}

if [ ! -d ${PACKAGE_DIR} ]; then
  mkdir ${PACKAGE_DIR}
fi

if [ ! -d ${SRPMS_DIR} ]; then
  mkdir ${SRPMS_DIR}
fi

cd ${BUILD_DIR}

step=0
f_step="000"

function next_step() {
  step=$((${step} + 1))
  f_step="$(printf '%0.3d' ${step})"
}

# kick this off in limited scope when specs update.

# gotta implement caching logic here. building every time sucks.
# find . -type f -exec sha256sum {} \;

# implement immediate move of RPMS to finished.
# signing.

function build_spec() {
  SPEC_FILE=${1}
  f_SPEC_FILE="$(tr . _ <<<${SPEC_FILE})"

  next_step

  log_file="${LOG_DIR}/${f_step}-${f_SPEC_FILE}.log"

  {
    rpmbuild \
      --define "_topdir ${BUILD_DIR}" \
      --define "__make /usr/bin/make -j 12" \
      -v \
      -ba \
      ${BUILD_DIR}/SPECS/${SPEC_FILE} \
      2>&1 1>&3 3>&- |
      tee -a "${log_file}.stderr"
  } 3>&1 1>&2 |
    tee -a "${log_file}"

  echo "$? -- ${PIPESTATUS}"
}

function install_rpms() {
  next_step

  log_file="${LOG_DIR}/${f_step}-install-rpms.log"

  dnf_cmd="dnf install -y ${BUILD_DIR}/RPMS/*/*.rpm"
  {
    ${dnf_cmd} 2>&1 1>&3 3>&- |
      tee -a "${log_file}.stderr"
  } 3>&1 1>&2 |
    tee -a "${log_file}"

}

pushd ${BUILD_DIR}/SPECS

cp -v /patches/* ${BUILD_DIR}/SOURCES/

build_spec zsh.spec

build_spec argparse-manpage.spec
build_spec python-ldap.spec
build_spec python-augeaus.spec
build_spec python-lesscpy.spec
build_spec python-pypng.spec
build_spec python-rjsmin.spec
build_spec python-wrapt.spec
build_spec pyusb.spec

install_rpms

build_spec certmonger.spec
build_spec python-qrcode

install_rpms

build_spec python-yubico.spec     # requires pyusb
build_spec python-deprecated.spec # requires wrapt

install_rpms

build_spec python-jwcrypto.spec # requires python-deprecated
build_spec 389-ds-base.spec     # requires argparse-manpage, python-ldap

install_rpms

build_spec freeipa.spec

install_rpms

#  rm -rf ${BUILD_DIR}/{RPMS,SRPMS}/*
