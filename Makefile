PREFIX_NAME ?= spack_playground
BASE_CONTAINER ?= centos-7
DOCKER_BUILD ?= DOCKER_BUILDKIT=1 docker build
DOCKER_OPTIONS ?= --pull=false
UID ?= $(shell id -u)
GID ?= $(shell id -g)

developer-${BASE_CONTAINER}: base-${BASE_CONTAINER}
	${DOCKER_BUILD} ${DOCKER_OPTIONS} -f spack-dev.dockerfile \
        --build-arg BASE_CONTAINER=${BASE_CONTAINER} \
        --build-arg USERID=${UID} --build-arg GROUPID=${GID} \
		-t ${PREFIX_NAME}:developer-${BASE_CONTAINER} .

base-${BASE_CONTAINER}: ${BASE_CONTAINER}
	${DOCKER_BUILD} ${DOCKER_OPTIONS} -f spack-base.dockerfile \
        --build-arg BASE_CONTAINER=${BASE_CONTAINER} \
		-t ${PREFIX_NAME}:base-${BASE_CONTAINER} .

${BASE_CONTAINER}:
	${DOCKER_BUILD} ${DOCKER_OPTIONS} -f ${BASE_CONTAINER}.dockerfile -t ${PREFIX_NAME}:${BASE_CONTAINER} .
