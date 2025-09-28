# Security Report

## Risks Identified
- Root containers
- Hardcoded secrets
- No pod-to-pod restrictions

## Implemented Solutions
- Non-root user in Docker & K8s
- Resource requests/limits defined
- NetworkPolicy restricting Mongo access

## Suggestions for Production
- Use Vault/AWS Secrets Manager
- Enable Kubernetes audit logs
- Add runtime security (Falco/AppArmor)
- Use IaC scans (tfsec/checkov)
