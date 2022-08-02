#!/bin/bash
cluster_name=$1
region=$2
aws eks update-kubeconfig --name $cluster_name
kubectl get cm aws-auth -n kube-system -o yaml >aws-auth-configmap.yaml
aws_account_id=$(aws sts get-caller-identity | jq --raw-output ".Account")
eksctl create iamidentitymapping --cluster $cluster_name --region=$region --arn arn:aws:iam::"$aws_account_id":role/ci_de_sre_role --group system:masters --username CI_DE_SRE:{{SessionName}}
eksctl create iamidentitymapping --cluster $cluster_name --region=$region --arn arn:aws:iam::"$aws_account_id":role/cogengineeringrole --group system:masters --username CogEngineering:{{SessionName}}
aws secretsmanager get-secret-value --secret-id cog-namespaces | jq --raw-output ".SecretString" >namespaces.yaml
aws secretsmanager get-secret-value --secret-id cog-argocd-secrets | jq --raw-output ".SecretString" >cog-argocd-secrets.yaml
aws secretsmanager get-secret-value --secret-id cog-docker-pull-image-secret | jq --raw-output ".SecretString" >cog-docker-pull-image-secret.yaml
#aws secretsmanager get-secret-value --secret-id cog-bnym-poc-vault-secret-id | jq --raw-output ".SecretString" >cog-bnym-poc-vault-secret-id.yaml

kubectl apply -f namespaces.yaml
kubectl apply -f cog-argocd-secrets.yaml
tier=$(aws eks describe-cluster --name $cluster_name | jq --raw-output ".cluster.tags.tier")
kubectl create ns $tier && kubectl label ns $tier istio-injection=enabled
kubectl apply -f cog-docker-pull-image-secret.yaml -n $tier
kubectl apply -f cog-docker-pull-image-secret.yaml -n argocd
kubectl apply -f cog-docker-pull-image-secret.yaml -n external-secrets-operator
#Install cog-docker-pull-image-secret in app ns, external-secrets-operator ns, argocd
