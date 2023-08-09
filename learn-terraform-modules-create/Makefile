#!make
SHELL=/bin/bash
RED=\033[0;31m
GREEN=\033[0;32m
BG_GREY=\033[48;5;237m
NC=\033[0m # No Color

#include project.env
#export $(shell sed 's/=.*//' project.env)

LOG_LEVEL ?= error

.PHONY: help

help:
	@echo R\&D \"learn-terraform-modules-create\" automation commands:
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#check-project-env-vars: ## Check if necessary env vars are set
	@#bash ../../ops/scripts/check-project-env-vars.sh $(LOG_LEVEL)

upload-static-content: bucketName=$(shell terraform output -raw website_bucket_name)
upload-static-content: ## upload-static-content to s3 bucket
	@printf "${BG_GREY}[upload-static-content] Start${NC}\n"
	@aws s3 cp ./modules/aws-s3-static-website-bucket/static/ \
		 s3://${bucketName}/ \
		 --recursive
	@printf "${BG_GREY}[upload-static-content] DONE${NC}\n"

delete-static-content: bucketName=$(shell terraform output -raw website_bucket_name)
delete-static-content: ## upload-static-content to s3 bucket
	@printf "${BG_GREY}[upload-static-content] Start${NC}\n"
	@aws s3 rm s3://${bucketName}/ --recursive
	@printf "${BG_GREY}[upload-static-content] DONE${NC}\n"

