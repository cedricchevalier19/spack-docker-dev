PREFIX_NAME = arcane
BASE_CONTAINER ?= centos-7
DOCKER_BUILD = docker build
DOCKER_OPTIONS = --pull=false
UID ?= $(shell id -u)
GID ?= $(shell id -g)

spack-dev-${BASE_CONTAINER}: spack-base-${BASE_CONTAINER}
	${DOCKER_BUILD} ${DOCKER_OPTIONS} -f spack-dev.dockerfile \
        --build-arg BASE_CONTAINER=${BASE_CONTAINER} \
        --build-arg USERID=${UID} --build-arg GROUPID=${GID} \
		-t ${PREFIX_NAME}:spack_dev-${BASE_CONTAINER} .

spack-base-${BASE_CONTAINER}: ${BASE_CONTAINER}
	${DOCKER_BUILD} ${DOCKER_OPTIONS} -f spack-base.dockerfile \
        --build-arg BASE_CONTAINER=${BASE_CONTAINER} \
        --build-arg USERID=${UID} --build-arg GROUPID=${GID} \
		-t ${PREFIX_NAME}:spack_base-${BASE_CONTAINER} .

${BASE_CONTAINER}:
	${DOCKER_BUILD} ${DOCKER_OPTIONS} -f ${BASE_CONTAINER}.dockerfile -t ${PREFIX_NAME}:${BASE_CONTAINER} .
