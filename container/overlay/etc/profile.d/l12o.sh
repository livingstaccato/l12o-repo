#!/etc/sh

export _l12o_s3_repo="repo-l12o-com"

export _l12o_repo="/repo"

export _l12o_build_dir="/build"

export _l12o_rpm_dir="/rpms"
export _l12o_srpm_dir="/srpms"


export HOST="container-${HOST}"

export PATH="/scripts:${PATH}"

alias trepo='pushd /home'
alias trpms='pushd /rpms'
alias tspecs='pushd /srpms'
alias tsrpms='pushd /srpms'
