# Requer: atmos, terraform, helmfile, az, kubelogin, kubectl

STACK ?= ue2/dev
AKS_RG ?= rg-platform-dev
AKS_NAME ?= aks-platform-dev

.PHONY: login
login:
	az login

.PHONY: up-dev
up-dev:
	atmos run workflow up-dev

.PHONY: kubeconfig
kubeconfig:
	az aks get-credentials -g $(AKS_RG) -n $(AKS_NAME) --overwrite-existing

.PHONY: ns
ns:
	kubectl apply -k stacks/kube/namespaces

.PHONY: helm-base
helm-base:
	atmos helmfile apply base -s $(STACK)

.PHONY: helm-dev
helm-dev:
	atmos helmfile apply dev -s $(STACK)

.PHONY: status
status:
	kubectl -n dev get pods
	kubectl -n cattle-system get pods
	kubectl -n ingress-nginx get pods
	kubectl -n cert-manager get pods

.PHONY: helm-gitops
helm-gitops:
	atmos helmfile apply gitops -s $(STACK)
