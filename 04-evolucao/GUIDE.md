---
title: "Stage 4 — Evolution Guide"
description: "Guide for infrastructure, CI/CD, and deployment of SIFAP 2.0"
author: "Paula Silva, AI-Native Software Engineer, Americas Global Black Belt at Microsoft"
date: "2026-04-24"
version: "1.2.0"
status: "approved"
tags: ["stage-4", "evolution", "infrastructure", "terraform", "azure", "ci-cd"]
---

# 🚀 Stage 4: Evolution

> ⏱️ **Duration**: 3 hours. Transform your working code into a resilient, scalable production system on Azure with Infrastructure as Code (Terraform) and automated CI/CD pipelines (GitHub Actions).

---

## 📑 Table of Contents

1. [Where are we on the journey](#-where-are-we-on-the-journey)
2. [Objective](#-objective)
3. [Infrastructure Architecture](#-infrastructure-architecture)
4. [Terraform Modules](#-terraform-modules)
5. [GitHub Actions CI/CD](#-github-actions-cicd)
6. [Deployment Strategy](#-deployment-strategy)
7. [Monitoring and Observability](#-monitoring-and-observability)
8. [Definition of Done](#-definition-of-done)
9. [Navigation](#-navigation)

---

## 🎬 Where are we on the journey

You've built working code (Stage 3). Now you operationalize it: infrastructure as code, automated testing/building, deployment pipelines, and monitoring. By end of Stage 4, you have a production-ready system on Azure.

**Key principle**: Infrastructure should be reproducible from code. Every environment (dev, stage, prod) should be identical except for scale.

---

## 🎯 Objective

Deploy SIFAP 2.0 to Azure with:
- Infrastructure as Code (Terraform)
- Automated CI/CD pipeline (GitHub Actions)
- Multi-environment support (dev, stage, prod)
- Monitoring and alerting (Azure Application Insights)
- Secrets management (Azure Key Vault)
- Compliance and security best practices

**Success metric**: One-click deployment to production with zero manual steps.

---

## 🏗️ Infrastructure Architecture

### Azure Services Used

| Service | Purpose | SKU/Tier |
|---------|---------|----------|
| App Service Plan | Compute for backend | B2 (shared) for dev; P1V2 for prod |
| App Service (Backend) | Java Spring Boot app | 1 instance (scale with load) |
| App Service (Frontend) | Next.js static hosting | Standard |
| PostgreSQL Flexible Server | Managed database | B_Standard_B1ms for dev |
| Key Vault | Secrets management | Standard |
| Application Insights | Monitoring/APM | Standard |
| Storage Account | Logs and backups | Standard_LRS |
| Virtual Network | Network isolation | Optional (for production) |

### Network Diagram

```
┌────────────────────────────────────────────────────┐
│              Azure Subscription                    │
├────────────────────────────────────────────────────┤
│                                                    │
│  ┌─────────────────────────────────────────────┐ │
│  │         Virtual Network (VNet)              │ │
│  │                                             │ │
│  │  ┌─────────────┐      ┌──────────────┐    │ │
│  │  │ App Service │      │ App Service  │    │ │
│  │  │  (Backend)  │      │ (Frontend)   │    │ │
│  │  └─────┬───────┘      └──────┬───────┘    │ │
│  │        │                     │             │ │
│  │        └──────────┬──────────┘             │ │
│  │                   │                        │ │
│  │        ┌──────────▼────────────┐          │ │
│  │        │  PostgreSQL Flexible  │          │ │
│  │        │  Server (Database)    │          │ │
│  │        └───────────────────────┘          │ │
│  │                                             │ │
│  └─────────────────────────────────────────────┘ │
│                                                    │
│  ┌────────────────────────────────────────────┐ │
│  │ Key Vault (Secrets)                        │ │
│  └────────────────────────────────────────────┘ │
│                                                    │
│  ┌────────────────────────────────────────────┐ │
│  │ Application Insights (Monitoring)          │ │
│  └────────────────────────────────────────────┘ │
│                                                    │
└────────────────────────────────────────────────────┘
```

---

## 🏗️ Terraform Modules

### Directory Structure

```
infra/
├─ main.tf
├─ variables.tf
├─ outputs.tf
├─ environments/
│  ├─ dev.tfvars
│  ├─ stage.tfvars
│  └─ prod.tfvars
├─ modules/
│  ├─ resource_group/
│  ├─ networking/
│  ├─ app_service/
│  ├─ database/
│  ├─ keyvault/
│  └─ monitoring/
└─ terraform.tfstate (git-ignored)
```

### Module 1: Resource Group

**File**: `modules/resource_group/main.tf`

```hcl
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  
  tags = {
    project     = "SIFAP"
    environment = var.environment
    managed_by  = "terraform"
  }
}

output "resource_group_id" {
  value = azurerm_resource_group.rg.id
}

output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}
```

### Module 2: App Service (Backend)

**File**: `modules/app_service/main.tf`

```hcl
resource "azurerm_service_plan" "backend" {
  name                = "plan-sifap-backend-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.environment == "prod" ? "P1V2" : "B2"
  
  tags = var.tags
}

resource "azurerm_linux_web_app" "backend" {
  name                = "app-sifap-backend-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.backend.id
  
  identity {
    type = "SystemAssigned"
  }
  
  site_config {
    application_stack {
      java_version = "21"
      java_server  = "TOMCAT"
      java_server_version = "10.1"
    }
    
    # Enable Application Insights
    application_insights_connection_string = var.app_insights_connection_string
  }
  
  app_settings = {
    SPRING_DATASOURCE_URL      = var.db_connection_string
    SPRING_DATASOURCE_USERNAME = var.db_username
    SPRING_DATASOURCE_PASSWORD = var.db_password
    SPRING_PROFILES_ACTIVE     = var.environment
  }
  
  tags = var.tags
}

resource "azurerm_app_service_managed_identity_certificate_binding" "backend" {
  app_service_certificate_id = var.certificate_id
  certificate_binding_type   = "SNI SSL"
  hostname_binding_id        = azurerm_app_service_custom_hostname_binding.backend.id
}

output "app_service_uri" {
  value = azurerm_linux_web_app.backend.default_hostname
}
```

### Module 3: PostgreSQL Database

**File**: `modules/database/main.tf`

```hcl
resource "azurerm_postgresql_flexible_server" "sifap" {
  name                = "psql-sifap-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  version             = "16"
  
  administrator_login    = var.db_admin_username
  administrator_password = var.db_admin_password
  
  sku_name = var.environment == "prod" ? "B_Standard_B2s" : "B_Standard_B1ms"
  storage_mb = 32768
  
  backup_retention_days        = var.environment == "prod" ? 35 : 7
  geo_redundant_backup_enabled = var.environment == "prod" ? true : false
  
  tags = var.tags
}

resource "azurerm_postgresql_flexible_server_database" "sifap" {
  server_id = azurerm_postgresql_flexible_server.sifap.id
  name      = "sifapdb"
  charset   = "UTF8"
  collation = "en_US.utf8"
}

# Audit table (immutable)
resource "null_resource" "audit_table" {
  provisioner "local-exec" {
    command = "psql -h ${azurerm_postgresql_flexible_server.sifap.fqdn} -U ${var.db_admin_username} -d sifapdb -c 'CREATE TABLE IF NOT EXISTS audit_log (id BIGSERIAL PRIMARY KEY, entity_type VARCHAR(20), entity_id BIGINT, operation VARCHAR(10), old_value TEXT, new_value TEXT, timestamp TIMESTAMP, user_id VARCHAR(20)); CREATE TRIGGER audit_immutable BEFORE DELETE ON audit_log FOR EACH ROW EXECUTE FUNCTION raise_immutable_error();'"
  }
  
  depends_on = [azurerm_postgresql_flexible_server_database.sifap]
}

output "db_fqdn" {
  value = azurerm_postgresql_flexible_server.sifap.fqdn
}

output "db_connection_string" {
  value = "jdbc:postgresql://${azurerm_postgresql_flexible_server.sifap.fqdn}:5432/sifapdb"
  sensitive = true
}
```

### Module 4: Key Vault

**File**: `modules/keyvault/main.tf`

```hcl
resource "azurerm_key_vault" "sifap" {
  name                = "kv-sifap-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = var.app_service_identity_object_id
    
    secret_permissions = [
      "Get",
      "List"
    ]
  }
  
  tags = var.tags
}

resource "azurerm_key_vault_secret" "db_password" {
  name         = "db-password"
  value        = var.db_admin_password
  key_vault_id = azurerm_key_vault.sifap.id
}

resource "azurerm_key_vault_secret" "api_key" {
  name         = "api-key"
  value        = var.api_key
  key_vault_id = azurerm_key_vault.sifap.id
}

output "key_vault_uri" {
  value = azurerm_key_vault.sifap.vault_uri
}
```

### Module 5: Application Insights

**File**: `modules/monitoring/main.tf`

```hcl
resource "azurerm_application_insights" "sifap" {
  name                = "appi-sifap-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  
  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "high_response_time" {
  name                = "alert-sifap-response-time"
  resource_group_name = var.resource_group_name
  scopes              = [azurerm_application_insights.sifap.id]
  description         = "Alert when response time exceeds 1000ms"
  
  criteria {
    metric_name      = "requests/duration"
    operator         = "GreaterThan"
    threshold        = 1000
    aggregation      = "Average"
  }
  
  action {
    action_group_id = var.action_group_id
  }
}

output "app_insights_connection_string" {
  value     = azurerm_application_insights.sifap.connection_string
  sensitive = true
}
```

### Root Configuration

**File**: `main.tf`

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
  }
  
  # Store state in Azure Storage
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "sttfstate"
    container_name       = "tfstate"
    key                  = "sifap.tfstate"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

module "resource_group" {
  source = "./modules/resource_group"
  
  resource_group_name = "rg-sifap-${var.environment}"
  location            = var.location
  environment         = var.environment
}

module "app_service" {
  source = "./modules/app_service"
  
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  environment         = var.environment
  
  depends_on = [module.resource_group]
}

module "database" {
  source = "./modules/database"
  
  resource_group_name = module.resource_group.resource_group_name
  location            = var.location
  environment         = var.environment
  
  depends_on = [module.resource_group]
}

module "keyvault" {
  source = "./modules/keyvault"
  
  resource_group_name             = module.resource_group.resource_group_name
  location                        = var.location
  environment                     = var.environment
  app_service_identity_object_id  = module.app_service.identity_principal_id
  
  depends_on = [module.app_service]
}
```

---

## 🔄 GitHub Actions CI/CD

### Workflow Structure

**File**: `.github/workflows/deploy.yml`

```yaml
name: Build & Deploy to Azure

on:
  push:
    branches:
      - main
      - stage
  pull_request:
    branches:
      - main
      - stage

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  # Job 1: Build and Test Backend (Java)
  build-backend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Java
        uses: actions/setup-java@v3
        with:
          java-version: '21'
          distribution: 'temurin'
          cache: maven
      
      - name: Build with Maven
        run: mvn clean package
      
      - name: Run tests
        run: mvn test
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./target/coverage.xml
  
  # Job 2: Build and Test Frontend (Next.js)
  build-frontend:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Set up Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Lint
        run: npm run lint
      
      - name: Run tests
        run: npm test
      
      - name: Build
        run: npm run build
      
      - name: Upload artifact
        uses: actions/upload-artifact@v3
        with:
          name: frontend-build
          path: .next
  
  # Job 3: Deploy to Azure (triggered on main or stage push)
  deploy:
    needs: [build-backend, build-frontend]
    if: github.event_name == 'push'
    runs-on: ubuntu-latest
    environment:
      name: ${{ github.ref == 'refs/heads/main' && 'production' || 'staging' }}
    
    steps:
      - uses: actions/checkout@v4
      
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
      
      - name: Deploy Infrastructure (Terraform)
        run: |
          cd infra
          terraform init
          terraform plan -var-file="environments/${{ github.ref == 'refs/heads/main' && 'prod' || 'stage' }}.tfvars"
          terraform apply -auto-approve -var-file="environments/${{ github.ref == 'refs/heads/main' && 'prod' || 'stage' }}.tfvars"
      
      - name: Deploy Backend to App Service
        uses: azure/webapps-deploy@v2
        with:
          app-name: app-sifap-backend-${{ github.ref == 'refs/heads/main' && 'prod' || 'stage' }}
          publish-profile: ${{ secrets.PUBLISH_PROFILE_BACKEND }}
          package: ./target/sifap-api.jar
      
      - name: Deploy Frontend to App Service
        uses: azure/webapps-deploy@v2
        with:
          app-name: app-sifap-frontend-${{ github.ref == 'refs/heads/main' && 'prod' || 'stage' }}
          publish-profile: ${{ secrets.PUBLISH_PROFILE_FRONTEND }}
          package: ./sifap-web/.next
      
      - name: Run smoke tests
        run: |
          npm install -g @playwright/test
          playwright test tests/smoke.spec.ts --config=playwright.config.ts
```

---

## 🚀 Deployment Strategy

### Environments

| Environment | Branch | Duration | Auto-deploy |
|---|---|---|---|
| Development (dev) | feature/* | Temporary | No (manual) |
| Staging (stage) | stage | Continuous | Yes (on push) |
| Production (prod) | main | Indefinite | Yes (on merge) |

### Deployment Steps

#### 1. Feature Development

```bash
git checkout -b feature/my-feature
# ... make changes ...
git push origin feature/my-feature
# ... create PR ...
```

#### 2. Code Review & Testing (PR Checks)

GitHub Actions automatically:
- Builds Java backend
- Runs unit tests
- Builds Next.js frontend
- Lint checks

#### 3. Merge to Staging

```bash
# After PR approval:
git checkout stage
git merge feature/my-feature
git push origin stage
```

#### 4. GitHub Actions Deploys to Staging

- Terraform plan reviewed manually
- `terraform apply` runs (with approval)
- Backend and frontend deployed
- Smoke tests run

#### 5. Verify in Staging

```bash
curl https://staging-sifap.azurewebsites.net/api/health
# Response: {"status": "UP"}
```

#### 6. Merge to Production

```bash
git checkout main
git merge stage
git push origin main
```

#### 7. GitHub Actions Deploys to Production

- Terraform apply (production environment)
- Backend and frontend deployed
- Smoke tests run
- Canary deployment (optional)

---

## �� Monitoring and Observability

### Application Insights Integration

**File**: `src/main/java/com/sifap/config/AppInsightsConfig.java`

```java
@Configuration
public class AppInsightsConfig {
  
  @Bean
  public WebClient webClient(WebClient.Builder builder) {
    return builder.build();
  }
  
  @Bean
  public RestTemplate restTemplate() {
    return new RestTemplate();
  }
}
```

**File**: `application.properties`

```properties
spring.application.insights.instrumentation-key=${APPINSIGHTS_INSTRUMENTATIONKEY}
management.endpoints.web.exposure.include=health,metrics,prometheus
management.metrics.export.prometheus.enabled=true
```

### Key Metrics to Monitor

| Metric | Target | Alert Threshold |
|--------|--------|-----------------|
| Response time (p99) | < 500ms | > 1000ms |
| Error rate | < 0.1% | > 1% |
| Database connection pool | < 80% | > 90% |
| CPU usage | < 60% | > 80% |
| Memory usage | < 70% | > 85% |

### Sample Alerts

**High Response Time Alert**:
```hcl
resource "azurerm_monitor_metric_alert" "high_response_time" {
  name = "sifap-high-response-time"
  criteria {
    metric_name = "http_request_duration_seconds"
    operator    = "GreaterThan"
    threshold   = 1
    aggregation = "Average"
  }
  action {
    action_group_id = var.action_group_id
  }
}
```

**High Error Rate Alert**:
```hcl
resource "azurerm_monitor_metric_alert" "high_error_rate" {
  name = "sifap-high-error-rate"
  criteria {
    metric_name = "requests_failed"
    operator    = "GreaterThan"
    threshold   = 100  # > 100 failures
  }
}
```

---

## ✅ Definition of Done

At end of Stage 4, you must have:

- [ ] **Infrastructure as Code**
  - [ ] All Azure resources defined in Terraform
  - [ ] Separate tfvars files for dev, stage, prod
  - [ ] State stored in Azure Storage backend
  - [ ] Terraform plan and apply tested

- [ ] **CI/CD Pipeline**
  - [ ] GitHub Actions workflows for build, test, deploy
  - [ ] Automated tests passing (unit + integration)
  - [ ] Linting passing (Java + TypeScript)
  - [ ] Code coverage tracked (70%+ backend, 60%+ frontend)

- [ ] **Deployment**
  - [ ] One-click deploy to staging
  - [ ] One-click deploy to production
  - [ ] Database migrations run automatically
  - [ ] Rollback plan documented

- [ ] **Monitoring**
  - [ ] Application Insights enabled
  - [ ] Key metrics tracked (response time, error rate, etc.)
  - [ ] Alerts configured
  - [ ] Runbook for common issues

- [ ] **Documentation**
  - [ ] Deployment steps documented
  - [ ] Troubleshooting guide created
  - [ ] Architecture diagrams (Terraform) documented
  - [ ] Operations runbook written

---

## Navigation

| Previous | Home |
|---|---|
| [Stage 3: Implementation](../03-implementacao/GUIDE.md) | [Kit README](../README.md) |

---

| Previous | Home | Next |
|:---------|:----:|-----:|
| [← Stage Home](README.md) | [Kit Home](../README.md) | [Agent Report →](agent-experience-report.md) |
