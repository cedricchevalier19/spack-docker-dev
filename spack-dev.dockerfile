ARG BASE_CONTAINER=centos7:0.1
FROM arcane/spack_base:0.1

LABEL maintener.email=<cedric.chevalier@cea.fr>
LABEL arcane.repository.tag=0.1
LABEL arcane.spack_dev.version=0.1

#USERNAME is from spack_base.

USER $USERNAME
WORKDIR /home/$USERNAME
SHELL ["/bin/bash", "-l", "-c"]

VOLUME "$SPACKUSERDIR"

ENTRYPOINT ["/bin/bash"]

