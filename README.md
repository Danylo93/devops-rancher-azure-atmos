# DevOps Rancher + Azure + Atmos + Kafka (Strimzi)

## Pré-requisitos
- Azure CLI (`az`), Terraform (>=1.6), Atmos (>=1.0), Helmfile, kubectl
- Permissão na Subscription
- DNS/host para Rancher (ou use nip.io)

## Passo a passo (DEV)
1. Ajuste `stacks/catalog/_defaults.yaml` (tenant, subscription, domínio Rancher) e `ansible/group_vars/all.yml` (kubeconfig, domínio, repositório GitOps). No WSL, por exemplo, use `kubeconfig: "/home/danylo/.kube/config"`.
2. `make login`
3. `make up-dev`  (RG, VNet, AKS + addons + Strimzi + Kafka)
4. `make kubeconfig`
5. `make ns` (aplica namespaces via Kustomize)
6. Instale dependências e faça o bootstrap de ingress, cert-manager, Rancher e Argo CD:
   ```bash
   ansible-galaxy collection install -r ansible/requirements.yml
   make ansible-all
   ```
7. Acessar Rancher via `https://<hostname>` e logar com `bootstrapPassword`.

## Verificando Kafka
```bash
kubectl -n dev get pods
kubectl -n dev get kafka,kafkatopic,kafkauser
```

## Estrutura GitOps
- Aplicações em `gitops/apps` utilizam Kustomize (`base` + `overlays/{dev,hml,prod}`) e são sincronizadas pelo Argo CD.
