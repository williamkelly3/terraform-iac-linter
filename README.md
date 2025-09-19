# 🧱 Terraform IaC Linter Project

This project provisions a **production-like Azure environment** using Terraform.  
It demonstrates **infrastructure as code (IaC)** best practices, security/compliance scanning, and GitHub Actions CI/CD.

The goal is to showcase DevOps best practices around code quality, reusability, and CI/CD automation — without needing to actually deploy resources to a cloud provider.

---

## 📁 Project Structure

```
terraform-iac-linter/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── providers.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   ├── staging/
│   └── prod/
│
├── modules/
│   ├── vnet/                # Virtual Network + Subnets + NSGs
│   ├── storage/             # Storage Account (secure defaults)
│   ├── vmss/                # Linux Virtual Machine Scale Set (with cloud-init)
│   ├── loadbalancer/        # Public Load Balancer for VMSS
│   ├── keyvault/            # Key Vault + Secrets + CMK
│   ├── monitoring/
│   │   ├── log_analytics/   # Centralized Log Analytics Workspace
│   │   └── diagnostic_settings/ # Diagnostic Settings for resources
│   └── policy/              # Azure Policy assignments (TLS enforcement)
│
├── .github/
│   └── workflows/
│       └── ci.yml           # GitHub Actions pipeline
│
├── cloud-init.sh            # Bootstrap script for VMSS
└── README.md

```

---

## 🚀 Features

- Multi-environment design (**dev**, **staging**, **prod**)
- Reusable **Terraform modules** for Azure resources
- **Security-first defaults**:
  - NSGs on subnets
  - HTTPS-only access
  - Enforce TLS 1.2+
  - Private endpoints
  - Customer Managed Key (CMK) support
- **Key Vault** with secret rotation & expiration
- **VMSS with Load Balancer** to simulate a web tier
- **Monitoring / Observability**:
  - Log Analytics
  - Diagnostic Settings
- **Compliance scanning** with:
  - [TFLint](https://github.com/terraform-linters/tflint) (linting)
  - [Checkov](https://www.checkov.io/) (policy as code)
  - `terraform fmt` and `terraform validate` checks
- **CI/CD** pipeline via **GitHub Actions**

---

## 🛠️ Prerequisites

- [Terraform CLI](https://developer.hashicorp.com/terraform/downloads) `>= 1.6.0`
- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [tflint](https://github.com/terraform-linters/tflint)
- [Checkov](https://github.com/bridgecrewio/checkov)


No Azure credentials or cloud access are required, this workflow is sandboxed for code-only validation.

---

## 🔒 Security Best Practices Implemented

- **Storage Accounts**
  - HTTPS only
  - Private endpoint support
  - Customer Managed Key (CMK) encryption

- **VMSS**
  - Host encryption enabled
  - SSH key authentication only (no passwords)
  - System-assigned managed identity

- **Key Vault**
  - Public network access disabled
  - Firewall rules enforced
  - Secrets & keys with expiration dates

- **VNET/Subnets**
  - NSG attached to each subnet
  - No inbound internet access by default

- **Azure Policy**
  - Enforces TLS 1.2+ on supported resources

---

## 🤖 CI/CD (GitHub Actions)

The pipeline (.github/workflows/ci.yml) runs on pull requests and pushes:
  1. terraform fmt -check
  2. terraform validate
  3. tflint
  4. checkov
  5. (Optional) terraform plan

To trigger, simply push changes to a branch or open a PR.

---

## 📊 Monitoring & Observability
- Log Analytics Workspace centralizes logs/metrics
- Diagnostic Settings forward logs from Storage, Key Vault, and VMSS
- Ready for integration with Azure Monitor or App Insights

---

## 📚 Skills Demonstrated
- Infrastructure as Code (IaC) with Terraform
- Azure cloud architecture (mocked resources)
- Modular code design and reusability
- CI/CD automation with GitHub Actions
- Code validation and formatting enforcement

---

## 📘 Notes
- Each environment (dev, staging, prod) has its own terraform.tfvars for isolation.
- Modules are designed to be reusable across projects.
- This repo is meant as a learning + demo project, but implements real production-grade practices.
