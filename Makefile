SHELL := /bin/bash

# List of targets the `readme` target should call before generating the readme
export README_DEPS ?= docs/targets.md docs/terraform.md

-include $(shell curl -sSL -o .build-harness "https://cloudposse.tools/build-harness"; echo .build-harness)

## Lint terraform code
lint:
	$(SELF) terraform/install terraform/get-modules terraform/get-plugins terraform/lint terraform/validate

## Pass arguments through to terraform which require remote state
apply console destroy graph plan output providers show: init
	terraform $@

## Pass arguments through to terraform which do not require remote state
get fmt validate version:
	terraform $@
