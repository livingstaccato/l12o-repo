#!/bin/sh

# 'bundles' as in just freeipa for now

source /etc/os-release

os_id=${ID}
os_version=${VERSION}
os_arch=${HOSTTYPE}

REPO_DIR=/repo/rpm/${os_id}/${os_version}

# Bundle up the RPMS required for a freeipa client.

CLIENT_PACKAGES="
certmonger-0
freeipa-client-4
freeipa-client-common-4
freeipa-client-samba-4
freeipa-common-4
freeipa-selinux-4
python3-deprecated-1
python3-ipaclient-4
python3-ipalib-4
python3-jwcrypto-1
python3-ldap-3
python3-pypng-0
python3-pyusb-1
python3-qrcode-7
python3-wrapt-1
python3-yubico-1
"

mkdir -p ${REPO_DIR}/bundles/freeipa-client/${os_arch}

for rpm in ${CLIENT_PACKAGES}; do
	printf '***\n*** %s\n***\n' ${rpm}

	rsync -av --progress --delete --include="${rpm}*.rpm" ${REPO_DIR}/${os_arch} ${REPO_DIR}/bundles/freeipa-client/

	printf '\n\n'
done
