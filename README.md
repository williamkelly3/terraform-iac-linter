# 🧱 Terraform IaC Linter Project

This project demonstrates clean, modular Infrastructure as Code (IaC) using **Terraform** for provisioning Azure resources, along with automated validation and formatting using **GitHub Actions**.

The goal is to showcase DevOps best practices around code quality, reusability, and CI/CD automation — without needing to actually deploy resources to a cloud provider.

---

## 📁 Project Structure

```
terraform-iac-linter/
├── modules/
│   ├── storage/
│   ├── vnet/
│   ├── vmss/
│   ├── loadbalancer/
│   ├── keyvault/
│   └── monitoring/
│       ├── main.tf                # Log Analytics + App Insights
│       ├── variables.tf
│       ├── outputs.tf
│       └── diagnostic_settings/
│           ├── main.tf            # Generic diagnostic settings resource
│           ├── variables.tf
│           └── outputs.tf
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   └── provider.tf
│   ├── staging/
│   │   ├── main.tf
│   │   └── provider.tf
│   └── prod/
│       ├── main.tf
│       └── provider.tf

```

---

## ⚙️ GitHub Actions Workflow

The CI pipeline automatically runs on push and pull requests to `main`:
- `terraform fmt -check`: Enforces consistent code formatting
- `terraform init`: Initializes Terraform configuration
- `terraform validate`: Validates syntax and configuration
- `terraform plan`: Runs a dry-run plan (non-deploying)

No Azure credentials or cloud access are required, this workflow is sandboxed for code-only validation.

---

## 📦 Module Overview: Azure Storage

The `modules/storage` folder contains a reusable Terraform module that defines an `azurerm_storage_account`. It uses variables for:
- Storage account name
- Resource group
- Location
- Tier and replication
- Tags

---

## 🧪 How to Use Locally

1. Clone the repo:
```bash
git clone https://github.com/williamkelly3/terraform-iac-linter.git
cd terraform-iac-linter/environments/dev
```

2. Run the standard Terraform workflow:
```bash
terraform init
terraform validate
terraform plan
```

---

## 📚 Skills Demonstrated
- Infrastructure as Code (IaC) with Terraform
- Azure cloud architecture (mocked resources)
- Modular code design and reusability
- CI/CD automation with GitHub Actions
- Code validation and formatting enforcement
