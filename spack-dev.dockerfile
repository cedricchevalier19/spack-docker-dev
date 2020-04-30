ARG BASE_CONTAINER=centos7:0.1
FROM arcane/spack_base:0.1

LABEL maintener.email=<cedric.chevalier@cea.fr>
LABEL arcane.repository.tag=0.1
LABEL arcane.spack_dev.version=0.1

ARG USERNAME=user
ARG USERPASSWORD=password
ARG USERID=1000
ARG GROUPID=1000
ARG SPACKUSERDIR=/home/${USERNAME}/spack

RUN useradd -g $GROUPID -u $USERID -m $USERNAME -s /bin/bash \
    yes $USERPASSWORD | passwd $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME
SHELL ["/bin/bash", "-l", "-c"]

RUN mkdir -p $SPACKUSERDIR \
  && ( echo ". $SPACKUSERDIR/share/spack/setup.sh" ) \
  >> ~/.bash_profile \
  && mkdir .spack \
  && (echo -n -e "upstreams:\n  main:\n" \
  &&  echo -n -e "   install_tree: $SPACK_ROOT/opt/spack" \
  &&  echo -n -e "   modules:\n      tcl: $SPACK_ROOT/share/spack/modules" ) \
  >> .spack/upstream.yaml \
  && . $SPACK_ROOT/share/spack/setup-env.sh \
  && spack compiler add $(spack location -i gcc@8.3.0)

VOLUME "$SPACKUSERDIR"

ENTRYPOINT ["/bin/bash", "/opt/spack/share/spack/docker/entrypoint.bash"]
CMD ["docker-shell"]
