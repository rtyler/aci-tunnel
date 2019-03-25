IMAGE=rtyler/aci-tunnel
IMAGE_TAG:=$(shell git rev-parse HEAD)

all: help

build: # Build the docker container
	docker build -t $(IMAGE):$(IMAGE_TAG) .
	docker tag $(IMAGE):$(IMAGE_TAG) $(IMAGE):latest

check: build # Verify the container

clean: # Clean up any built resources
	docker rmi $$(docker images -q -f "reference=$(IMAGE)") || true

# Cute hack thanks to:
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## Display this help text
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all build check clean help
