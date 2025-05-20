# 🌐 GCP Translate & Text-to-Speech CI/CD Pipeline

## Overview

This project demonstrates a secure, automated CI/CD pipeline for a serverless GCP solution that translates uploaded text files and converts the translated output to speech.

### 🔧 Stack
- **Cloud Functions (GCP)** — Handles translation and TTS workflows
- **Terraform** — Infrastructure as Code
- **GitHub Actions** — CI/CD pipeline
- **Checkov** — Security scanning for Terraform and GitHub Actions
- **Workload Identity Federation** — Secure authentication (no keys!)

---

## ⚙️ CI/CD Workflow

| Job            | Description                                                                 |
|----------------|-----------------------------------------------------------------------------|
| `build`        | Packages and uploads two Cloud Functions (translation + TTS)               |
| `security-scan`| Runs Checkov on IaC and workflow code (SARIF report upload for visibility) |
| `plan`         | Runs Terraform plan, stores artifacts for review                            |
| `apply`        | Applies Terraform config (triggered on merge to `production` or manually)   |

---

## 🔐 Security Features

- Uses **GCP Workload Identity** (OIDC) for secure GitHub → GCP access
- Integrates **Checkov** for static security analysis of:
  - Terraform configurations
  - GitHub Actions workflows

---

## 🚀 What’s Next

If this were a production system, the next improvements would be:

- ✅ Canary deployments using [Cloud Functions v2](https://cloud.google.com/functions/docs/configuring-traffic-splitting)
- ✅ Monitoring with **SLI-based rollback triggers**
- ✅ Multi-environment support (dev/staging/prod)
- ✅ Policy gates before `terraform apply`

---