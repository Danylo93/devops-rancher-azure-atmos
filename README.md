# DevOps Rancher + Azure

## Pré-requisitos
- Azure CLI (`az`) e Terraform (>=1.6)
- Permissão na Subscription
- Domínio `quantum-flow.tech` apontando para o IP público

## Passo a passo (DEV)
1. Ajuste `infra/terraform/live/dev/dev.tfvars` com sua subscription, tenant e chave SSH.
2. `make login`
3. `make up-dev` (cria Resource Group, VNet e VM)
4. Aponte o DNS de `quantum-flow.tech` para o IP público exibido na saída.
5. Acesse a VM e instale o Rancher na versão latest.
