# VoiceOwl DevSecOps Assignment

This repository demonstrates the secure deployment of a Node.js + MongoDB microservice on AWS EKS using DevSecOps best practices.

---

# Application Overview
- Backend: Node.js / Express (simple form submission API).
- Database: MongoDB (running as Deployment + Service).
- Containerization: Multi-stage Dockerfile with non-root user.
- Deployment: Terraform (VPC + EKS) + Kubernetes manifests.
- Security: Image hardening, resource limits, network policies.
- Monitoring: Datadog agent + alert configuration.
- CI/CD: GitHub Actions pipeline with Semgrep + Trivy scans.

---

# Setup Instructions

# 1. Build & Push Docker Image
```bash
# Authenticate to ECR
aws ecr get-login-password --region us-east-1 \
  | docker login --username AWS --password-stdin 831926624156.dkr.ecr.us-east-1.amazonaws.com

# Build and push
docker build -t voiceowl-app:latest .
docker tag voiceowl-app:latest 831926624156.dkr.ecr.us-east-1.amazonaws.com/voiceowl-app:latest
docker push 831926624156.dkr.ecr.us-east-1.amazonaws.com/voiceowl-app:latest

# 1. Build & Push Docker Image
   
   cd infra
   terraform init
   terraform apply -auto-approve



