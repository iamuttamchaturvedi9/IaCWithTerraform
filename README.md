## Financial Transactions Infrastructure on Azure (Terraform)

This project provisions a simple **financial transactions backend** on Azure using **Terraform**. It creates one resource group that contains multiple App Service plans and Linux web apps (for different APIs), plus separate Azure SQL servers and databases for each domain.

### What this infrastructure creates

- **Resource group**
  - `rg-financialtransaction-northeurope` in `northeurope`
- **App Service plans** (Linux, `F1` free tier)
  - `plan_apigateway-northeurope`
  - `plan_transaction-northeurope`
  - `plan_balance-northeurope`
  - `plan_transfer-northeurope`
  - `plan_notification-northeurope`
- **Linux web apps** (Docker, currently `nginx:latest` as a placeholder)
  - `appserv-apigateway-northeurope`
  - `appserv-transaction-northeurope`
  - `appserv-balance-northeurope`
  - `appserv-transfer-northeurope`
  - `appserv-notification-northeurope`
- **Azure SQL servers and databases** (per domain)
  - Transaction: `sqlserver-transaction` + `sqlserver-transaction-northeurope`
  - Balance: `sqlserver-balance` + `sqlserver-balance-northeurope`
  - Transfer: `sqlserver-transfer` + `sqlserver-transfer-northeurope`

You can replace the default `nginx:latest` images and SQL credentials with your own application containers and secure secrets.

### Prerequisites

- **Terraform** `>= 1.2`
- **Azure subscription** with permissions to create App Service and SQL resources
- **Azure CLI** (`az`) installed and logged in with access to the target subscription

> **Important**: The current `main.tf` file hardcodes `subscription_id` and SQL admin credentials. For real environments, move these to variables or environment variables and store secrets securely (for example, in Azure Key Vault or your CI/CD secret store).

### Authentication

For local runs:

```bash
az login --tenant <TENANT_ID>
az account set --subscription <SUBSCRIPTION_ID>
```

Alternatively, you can configure a **service principal** and set the standard Terraform Azure environment variables (`ARM_TENANT_ID`, `ARM_SUBSCRIPTION_ID`, `ARM_CLIENT_ID`, `ARM_CLIENT_SECRET`) if you are running this from CI/CD.

### How to use

From the repository root:

```bash
terraform init
terraform plan
terraform apply
```

To destroy everything created by this configuration:

```bash
terraform destroy
```

### Customization

- **Locations and names**: Update resource names and `location` values in `main.tf` to match your environment and naming standards.
- **App images**: Replace `docker_image_name = "nginx:latest"` with your own container images.
- **Database settings**: Change SQL admin login/password and database SKU as needed. Use variables and secret management for production.

### Notes

- This configuration is intended as a **learning / demo setup** for Infrastructure as Code with Terraform on Azure.
- Review Azure costs (even for free/low tiers) before applying in a shared or production subscription.

