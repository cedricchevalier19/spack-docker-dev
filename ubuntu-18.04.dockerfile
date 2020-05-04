FROM ubuntu:18.04

LABEL maintener.email=<cedric.chevalier@cea.fr>

LABEL arcane.repository.tag=0.1
LABEL arcane.ubuntu1804.version=0.1

ENV FORCE_UNSAFE_CONFIGURE=1          \
  DEBIAN_FRONTEND=noninteractive

RUN apt-get -yqq update                           \
 && apt-get -yqq install --no-install-recommends  \
        build-essential                           \
        ca-certificates                           \
        curl                                      \
        file                                      \
        g++                                       \
        gcc                                       \
        gfortran                                  \
        git                                       \
        gnupg2                                    \
        iproute2                                  \
        lmod                                      \
        locales                                   \
        lua-posix                                 \
        make                                      \
        openssh-server                            \
        python3                                   \
        python3-pip                               \
        tcl                                       \
        unzip                                     \
 && locale-gen en_US.UTF-8                        \
 && pip3 install boto3                            \
 && rm -rf /var/lib/apt/lists/*

# Add LANG default to en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# [WORKAROUND]
# https://bugs.launchpad.net/ubuntu/+source/lua-posix/+bug/1752082
RUN ln -s posix_c.so /usr/lib/x86_64-linux-gnu/lua/5.2/posix.so

