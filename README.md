# DevOps Rancher + Azure + Atmos + Kafka (Strimzi)

## Pré-requisitos
- Azure CLI (`az`), Terraform (>=1.6), Atmos (>=1.0), Helmfile, kubectl
- Permissão na Subscription
- DNS/host para Rancher (ou use nip.io)

## Passo a passo (DEV)
1. Ajuste `stacks/catalog/_defaults.yaml` (tenant, subscription, domínio Rancher).
2. `make login`
3. `make up-dev`  (RG, VNet, AKS + addons + Strimzi + Kafka)
4. `make kubeconfig`
5. Acessar Rancher via `https://<hostname>` e logar com `bootstrapPassword`.

## Verificando Kafka
```bash
kubectl -n dev get pods
kubectl -n dev get kafka,kafkatopic,kafkauser
