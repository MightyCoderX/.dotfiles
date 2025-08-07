.PHONY: build_arch build_fedora run_arch build_fedora

ARCH_IMAGE_NAME := dotfiles-arch
FEDORA_IMAGE_NAME := dotfiles-fedora


build_arch:
	docker build -f Dockerfile.arch -t ${ARCH_IMAGE_NAME}

build_fedora:
	docker build -f Dockerfile.fedora -t ${FEDORA_IMAGE_NAME}


run_arch: build_arch
	docker run --rm -it ${ARCH_IMAGE_NAME}

run_fedora: build_fedora
	docker run --rm -it ${FEDORA_IMAGE_NAME}

