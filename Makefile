SHELL := /bin/bash
ENV ?= development

.PHONY: setup fmt lint validate test plan up down health clean

setup:
	bash scripts/init.sh

fmt:
	terraform fmt -recursive

lint:
	terraform fmt -check -recursive -diff
	tflint --recursive
	trivy config --severity HIGH,CRITICAL --exit-code 1 --skip-dirs .terraform .

validate:
	terraform validate

test:
	terraform test

plan:
	bash scripts/plan.sh $(ENV)

up:
	bash scripts/apply.sh $(ENV)

down:
	bash scripts/destroy.sh $(ENV)

health:
	bash scripts/healthcheck.sh

clean:
	rm -rf .terraform plans
