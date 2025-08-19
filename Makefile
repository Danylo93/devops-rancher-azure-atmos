.PHONY: tf-init tf-apply kube ansible-ingress ansible-issuers ansible-rancher ansible-argocd

ENV ?= dev
TF_DIR=infra/terraform/live/$(ENV)

tf-init:
	cd $(TF_DIR) && terraform init

tf-apply:
	cd $(TF_DIR) && terraform apply -var-file=$(ENV).tfvars -auto-approve

kube:
	@RG=$$(terraform -chdir=$(TF_DIR) output -raw rg_name 2>/dev/null || echo "$(ENV)-rg"); \
	AKS=$$(terraform -chdir=$(TF_DIR) output -raw aks_name 2>/dev/null || echo "$(ENV)-aks"); \
	./scripts/get_kubeconfig.sh $$RG $$AKS

ansible-ingress:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-ingress-and-cert.yml

ansible-issuers:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/issuers-letsencrypt.yml

ansible-rancher:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-rancher.yml

ansible-argocd:
	ansible-playbook -i ansible/inventory.ini ansible/playbooks/bootstrap-argocd.yml