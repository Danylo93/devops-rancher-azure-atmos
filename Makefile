.RECIPEPREFIX := >

# ===== Config =====
ENV ?= dev
TF_DIR := infra/terraform/live/$(ENV)

# Lê o prefix do dev.tfvars (ex.: myco-dev)
PREFIX ?= $(shell awk -F'=' '/^prefix/{gsub(/[ \"\], "", $$2); print $$2}' $(TF_DIR)/$(ENV).tfvars)
RG_NAME ?= $(PREFIX)-rg

# Informe sua assinatura Azure ao rodar: make login SUBSCRIPTION_ID=<id>
SUBSCRIPTION_ID ?=

# ===== Helpers =====
.PHONY: help
help:
> @echo "Targets:"
> @echo "  login                  -> az login e seleciona a subscription"
> @echo "  up-dev                 -> terraform init && apply em $(TF_DIR)"
> @echo "  destroy                -> terraform destroy"

# ===== Azure login =====
.PHONY: login
login:
> @if [ -z "$(SUBSCRIPTION_ID)" ]; then echo "Use: make login SUBSCRIPTION_ID=<sua-sub>"; exit 2; fi
> @./scripts/az_login.sh "$(SUBSCRIPTION_ID)"

# ===== Terraform =====
.PHONY: up-dev
up-dev:
> cd $(TF_DIR) && terraform init -upgrade
> cd $(TF_DIR) && terraform apply -var-file=$(ENV).tfvars -auto-approve

.PHONY: destroy
destroy:
> cd $(TF_DIR) && terraform destroy -var-file=$(ENV).tfvars -auto-approve
