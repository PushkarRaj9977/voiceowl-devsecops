# VoiceOwl DevSecOps Assignment

This repository demonstrates the secure deployment of a Node.js + MongoDB microservice on AWS EKS using DevSecOps best practices.

---

## Application Overview
- **Backend**: Node.js / Express (simple form submission API).
- **Database**: MongoDB (running as Deployment + Service).
- **Containerization**: Multi-stage Dockerfile with non-root user.
- **Deployment**: Terraform (VPC + EKS) + Kubernetes manifests.
- **Security**: Image hardening, resource limits, network policies.
- **Monitoring**: Datadog agent + alert configuration.
- **CI/CD**: GitHub Actions pipeline with Semgrep + Trivy scans.

---

## Setup Instructions


```bash
# Authenticate to ECR
aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin 831926624156.dkr.ecr.us-east-1.amazonaws.com

# Build and push
docker build -t voiceowl-app:latest .
docker tag voiceowl-app:latest 831926624156.dkr.ecr.us-east-1.amazonaws.com/voiceowl-app:latest
docker push 831926624156.dkr.ecr.us-east-1.amazonaws.com/voiceowl-app:latest

# Provision Infrastructure (Terraform)
cd infra
terraform init
terraform apply -auto-approve

# Deploy to Kubernetes
cd k8s
kubectl apply -f mongo.yaml
kubectl apply -f deployment.yaml
kubectl apply -f ingress.yaml   # optional

# Validate 
kubectl get pods
kubectl get svc voiceowl-service

# Security Best Practices Implemented
Multi-stage build with minimal base image (distroless).
Non-root container execution (runAsUser: 1001).
Resource requests & limits for all pods.
NetworkPolicy restricting app → mongo only.
GitHub Actions CI/CD
Semgrep → static code analysis.
Trivy → image vulnerability scanning.
Fail pipeline on HIGH/CRITICAL issues.
Push to ECR + deploy only if scans pass.

# Monitoring & Observability
Datadog Agent deployed as DaemonSet.
Alert: High CPU usage in cluster.
Logs + APM enabled.

# Deliverables
Dockerfile (multi-stage, hardened).
Terraform IaC (VPC + EKS).
Kubernetes manifests (app, mongo, ingress, network policy).
GitHub Actions CI/CD workflow.
Datadog agent + alert config.
