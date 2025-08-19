# ===== Config =====
ENV ?= dev
TF_DIR := infra/terraform/live/$(ENV)

# Lê o prefix do dev.tfvars (ex.: myco-dev)
PREFIX ?= $(shell awk -F'=' '/^prefix/{gsub(/[ "]/,"",$$2);print $$2}' $(TF_DIR)/$(ENV).tfvars)
RG_NAME ?= $(PREFIX)-rg
AKS_NAME ?= $(PREFIX)-aks

# Informe sua assinatura Azure ao rodar: make login SUBSCRIPTION_ID=<id>
SUBSCRIPTION_ID ?=

# Caminho do kubeconfig (WSL)
KUBECONFIG_PATH ?= /home/$(USER)/.kube/config

ANSIBLE_PY := $(HOME)/.ansible-venv/bin/python
ANS_ENV := ANSIBLE_PYTHON_INTERPRETER=$(ANSIBLE_PY)

ansible-ingress:
	$(ANS_ENV) ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-ingress-and-cert.yml

ansible-issuers:
	$(ANS_ENV) ansible-playbook -i ansible/inventory.ini ansible/playbooks/issuers-letsencrypt.yml

ansible-rancher:
	$(ANS_ENV) ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-rancher.yml

ansible-argocd:
	$(ANS_ENV) ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-argocd.yml


# ===== Helpers =====
.PHONY: help
help:
	@echo "Targets:"
	@echo "  login                  -> az login e seleciona a subscription"
	@echo "  up-dev                 -> terraform init && apply em $(TF_DIR)"
	@echo "  kubeconfig             -> pega kubeconfig (az aks get-credentials)"
	@echo "  ns                     -> cria namespaces base (ingress, cert-manager, rancher, argocd)"
	@echo "  ansible-deps           -> instala coleções Ansible"
	@echo "  ansible-ingress        -> instala ingress-nginx + cert-manager"
	@echo "  ansible-issuers        -> cria ClusterIssuer Let's Encrypt"
	@echo "  ansible-rancher        -> instala Rancher"
	@echo "  ansible-argocd         -> instala Argo CD"
	@echo "  ansible-all            -> roda tudo (ingress, issuers, rancher, argocd)"
	@echo "  scale-2                -> escala AKS para 2 nós (resolve Too many pods)"
	@echo "  destroy                -> terraform destroy"

# ===== Azure login =====
.PHONY: login
login:
	@if [ -z "$(SUBSCRIPTION_ID)" ]; then echo "Use: make login SUBSCRIPTION_ID=<sua-sub>"; exit 2; fi
	@./scripts/az_login.sh "$(SUBSCRIPTION_ID)"

# ===== Terraform =====
.PHONY: up-dev
up-dev:
	cd $(TF_DIR) && terraform init -upgrade
	cd $(TF_DIR) && terraform apply -var-file=$(ENV).tfvars -auto-approve

.PHONY: destroy
destroy:
	cd $(TF_DIR) && terraform destroy -var-file=$(ENV).tfvars -auto-approve

# ===== Kubeconfig =====
.PHONY: kubeconfig
kubeconfig:
	@./scripts/get_kubeconfig.sh "$(RG_NAME)" "$(AKS_NAME)"
	@mkdir -p $(dir $(KUBECONFIG_PATH))
	@echo "KUBECONFIG pronto: $(KUBECONFIG_PATH)"

# ===== Namespaces base =====
.PHONY: ns
ns:
	kubectl create ns ingress-nginx --dry-run=client -o yaml | kubectl apply -f -
	kubectl create ns cert-manager  --dry-run=client -o yaml | kubectl apply -f -
	kubectl create ns cattle-system --dry-run=client -o yaml | kubectl apply -f -
	kubectl create ns argocd        --dry-run=client -o yaml | kubectl apply -f -

# ===== Ansible =====
.PHONY: ansible-deps
ansible-deps:
	ansible-galaxy collection install -r ansible/requirements.yml

.PHONY: ansible-ingress
ansible-ingress:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-ingress-and-cert.yml

.PHONY: ansible-issuers
ansible-issuers:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/issuers-letsencrypt.yml

.PHONY: ansible-rancher
ansible-rancher:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-rancher.yml

.PHONY: ansible-argocd
ansible-argocd:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-argocd.yml

.PHONY: ansible-all
ansible-all: ansible-deps ansible-ingress ansible-issuers ansible-rancher ansible-argocd

# ===== AKS scale (para liberar pods) =====
.PHONY: scale-2
scale-2:
	az aks scale -g "$(RG_NAME)" -n "$(AKS_NAME)" --node-count 2
