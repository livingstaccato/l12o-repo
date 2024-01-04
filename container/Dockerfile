FROM public.ecr.aws/amazonlinux/amazonlinux:2023

RUN         \
dnf upgrade \
--assumeyes \
&& echo "exit code: ${?}"

RUN                 \
dnf groupinstall    \
--assumeyes         \
'Development Tools' \
\
&&           \
dnf install  \
--assumeyes  \
findutils    \
libsemanage  \
shadow-utils \
&& echo "exit code: ${?}"

RUN       \
groupadd  \
--system  \
--gid 420 \
build     \
&& echo "exit code: ${?}"

RUN \
echo useradd           \
--system               \
--uid 420              \
--gid 420              \
--comment "build user" \
--home-dir /build      \
--shell /bin/bash      \
build                  \
&& echo "exit code: ${?}"

COPY /pkgs/* /pkgs/
COPY /scripts/_l12o-install-packages.sh /scripts/

RUN /scripts/_l12o-install-packages.sh

WORKDIR /

RUN chsh --shell /bin/zsh root

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Might as well get rid of /root
RUN \
mv /root/.* / \
\
&&  rm -rf /root \
&&  sed -i 's|:/root|:/|g' /etc/passwd

COPY /container/overlay/ /
COPY /scripts/* /scripts/


CMD zsh
