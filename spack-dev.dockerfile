ARG BASE_CONTAINER=centos-7
FROM spack_playground:base-$BASE_CONTAINER

LABEL maintener.email=<cedric.chevalier@cea.fr>
LABEL spack_playground.repository.tag=0.1
LABEL spack_playground.developer.version=0.1

ENV USERNAME=user
ARG USERID=1000
ARG GROUPID=1000
ENV SPACKUSERDIR=/home/${USERNAME}/spack

RUN groupadd -g $GROUPID $USERNAME \
  && useradd -g $GROUPID -u $USERID -m -s /bin/bash ${USERNAME}


USER $USERNAME
WORKDIR /home/$USERNAME
SHELL ["/bin/bash", "-l", "-c"]

RUN mkdir -p $SPACKUSERDIR \
  && ( echo ". $SPACKUSERDIR/share/spack/setup-env.sh" ) \
  >> ~/.bash_profile \
  && mkdir .spack \
  && (echo -n -e "upstreams:\n  main:\n" \
  &&  echo -n -e "   install_tree: $SPACK_UPSTREAM_ROOT/opt/spack\n" \
  &&  echo -n -e "   modules:\n      tcl: $SPACK_UPSTREAM_ROOT/share/spack/modules\n" ) \
  >> .spack/upstreams.yaml \
  && . $SPACK_UPSTREAM_ROOT/share/spack/setup-env.sh \
  && spack compiler add /usr/bin \
  && spack compiler add $(spack location -i gcc@8.3.0)

VOLUME "$SPACKUSERDIR"

ENTRYPOINT ["/bin/bash", "-l"]

