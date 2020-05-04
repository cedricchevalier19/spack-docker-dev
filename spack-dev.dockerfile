ARG BASE_CONTAINER=centos-7
FROM arcane:spack_base-$BASE_CONTAINER

LABEL maintener.email=<cedric.chevalier@cea.fr>
LABEL arcane.repository.tag=0.1
LABEL arcane.spack_dev.version=0.1

#USERNAME is from spack_base.

USER $USERNAME
WORKDIR /home/$USERNAME
SHELL ["/bin/bash", "-l", "-c"]

VOLUME "$SPACKUSERDIR"

ENTRYPOINT ["/bin/bash"]

