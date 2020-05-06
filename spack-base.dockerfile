ARG BASE_CONTAINER=centos-7
FROM spack_playground:${BASE_CONTAINER}

LABEL maintener.email=<cedric.chevalier@cea.fr>

LABEL spack_playground.repository.tag=0.1
LABEL spack_playground.base.version=0.1

ARG CURRENTLY_BUILDING_DOCKER_IMAGE=1

ENV FORCE_UNSAFE_CONFIGURE=1          \
    SPACK_UPSTREAM_ROOT=/opt/spack

RUN ( echo ". $SPACK_UPSTREAM_ROOT/share/spack/setup-env.sh"                \
 &&   echo "if [ \"\$CURRENTLY_BUILDING_DOCKER_IMAGE\" '!=' '1' ]"  \
 &&   echo "then"                                                   \
 &&   echo "  . $SPACK_UPSTREAM_ROOT/share/spack/spack-completion.bash"     \
 &&   echo "fi"                                                   ) \
       >> /etc/profile.d/spack.sh

# [WORKAROUND]
# https://superuser.com/questions/1241548/
#     xubuntu-16-04-ttyname-failed-inappropriate-ioctl-for-device#1253889
RUN [ -f ~/.profile ]                                               \
 && sed -i 's/mesg n/( tty -s \\&\\& mesg n || true )/g' ~/.profile \
 || true

ARG SPACK_VERSION=0.14.2
# Install last release for spack, as upstream
RUN mkdir -p $SPACK_UPSTREAM_ROOT && \
  curl -s -L https://github.com/spack/spack/releases/download/v${SPACK_VERSION}/spack-${SPACK_VERSION}.tar.gz \
  | tar xzC $SPACK_UPSTREAM_ROOT --strip 1

# note: at this point one could also run ``spack bootstrap`` to avoid
#       parts of the long apt-get install list above

# install software
RUN        . /etc/profile.d/spack.sh \
#  && spack bootstrap \
  && spack install gcc@8.3.0 \
  && spack compiler add `spack location -i gcc` \
  && spack clean -a

ENTRYPOINT ["/bin/bash", "-l"]

