# DevOps Rancher + Azure + Terraform

## Pré-requisitos
- Azure CLI (`az`)
- Terraform (>=1.6)
- Permissão na Subscription

## Como usar
1. Ajuste as variáveis em `terraform/terraform.tfvars` (consulte o arquivo `terraform.tfvars.example`).
2. Acesse o diretório `terraform` e inicialize: `terraform init`.
3. Aplique a infraestrutura: `terraform apply -var-file=terraform.tfvars`.

Os módulos provisionam o grupo de recursos, rede virtual e cluster AKS na Azure.
