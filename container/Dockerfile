FROM public.ecr.aws/amazonlinux/amazonlinux:2023

RUN         \
dnf upgrade \
--assumeyes \
&& echo "dnf upgrade exit code: ${?}" \
\
&& dnf install  \
--assumeyes  \
findutils    \
libsemanage  \
shadow-utils \
util-linux \ 
util-linux-user \ 
&& echo "dnf install exit code: ${?}" \
\
&& dnf groupinstall    \
--assumeyes         \
'Development Tools' \
&& echo "dnf groupinstall exit code: ${?}" \
\
&& groupadd     \
--system   \
--gid 420  \
build     \
&& echo "groupadd exit code: ${?}" \
\
&& useradd             \
--system               \
--uid 420              \
--gid 420              \
--comment "build user" \
--home-dir /build      \
--shell /bin/bash      \
build                  \
&& echo "useradd exit code: ${?}"

COPY /pkgs/* /pkgs/
COPY /scripts/_l12o-install-packages.sh /scripts/
RUN /scripts/_l12o-install-packages.sh

WORKDIR /

RUN \
dnf install --assumeyes zsh \
&& sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended 

RUN /usr/bin/chsh --shell /bin/zsh root

# Might as well get rid of /root
RUN \
mv /root/.* / \
\
&&  rm -rf /root \
&&  sed -i 's|:/root|:/|g' /etc/passwd

COPY /container/overlay/ /
COPY /scripts/* /scripts/


CMD zsh
