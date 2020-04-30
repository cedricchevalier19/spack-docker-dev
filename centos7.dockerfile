FROM centos:7

LABEL maintener.email=<cedric.chevalier@cea.fr>

LABEL arcane.repository.tag=0.1
LABEL arcane.centos7.version=0.1

ENV FORCE_UNSAFE_CONFIGURE=1          \
    DEBIAN_FRONTEND=noninteractive

RUN yum update -y                                             \
 && yum install -y epel-release                               \
 && yum update -y                                             \
 && yum --enablerepo epel groupinstall -y "Development Tools" \
 && yum --enablerepo epel install -y                          \
        curl           findutils gcc-c++    gcc               \
        gcc-gfortran   git       gnupg2     hostname          \
        iproute        Lmod      make       patch             \
        openssh-server python    python-pip tcl               \
        unzip          which                                  \
 && pip install boto3                                         \
 && rm -rf /var/cache/yum                                     \
 && yum clean all

