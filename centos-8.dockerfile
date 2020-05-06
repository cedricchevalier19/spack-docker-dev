FROM centos:8

LABEL maintener.email=<cedric.chevalier@cea.fr>

LABEL spack_playground.repository.tag=0.1
LABEL spack_playground.centos8.version=0.1

ENV FORCE_UNSAFE_CONFIGURE=1          \
    DEBIAN_FRONTEND=noninteractive

RUN yum update -y                                             \
 && yum install -y epel-release dnf-plugins-core               \
  && yum update -y                                             \
  && dnf config-manager --set-enabled PowerTools \
 && yum --enablerepo epel groupinstall -y "Development Tools" \
 && yum --enablerepo epel install -y                          \
        curl           findutils gcc-c++    gcc               \
        gcc-gfortran   git       gnupg2     hostname          \
        iproute        Lmod      make       patch             \
        openssh-server python3   python3-devel python3-pip tcl \
        unzip          which     passwd                        \
 && pip3 install boto3                                         \
 && rm -rf /var/cache/yum                                     \
 && yum clean all

