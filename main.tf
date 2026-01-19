terraform {
  required_version = ">= 1.2"
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm",
        version = "~> 4.2"
    }
  }    
}

provider "azurerm"{
    subscription_id = ""
    features{
        resource_group{
            prevent_deletion_if_contains_resources = false
        }
    }
}

resource "azurerm_resource_group" "rg"{
    name = "rg-financialtransaction-northeurope"
    location = "northeurope"
}

# API Gateway

resource "azurerm_service_plan" "plan_apigateway" {
    name = "plan_apigateway-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    os_type = "Linux"
    sku_name = "F1"    
}

resource  "azurerm_linux_web_app" "appservice-apigateway" {
    name = "appserv-apigateway-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.plan_apigateway.id
    site_config {
        always_on = false
        application_stack {
            docker_image_name = "nginx:latest"
        }
    }
}

# API Transaction

resource "azurerm_service_plan" "plan_transaction" {
    name = "plan_transaction-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    os_type = "Linux"
    sku_name = "F1"    
}

resource  "azurerm_linux_web_app" "appservice-transaction" {
    name = "appserv-transaction-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.plan_transaction.id
    site_config {
        always_on = false
        application_stack {
            docker_image_name = "nginx:latest"
        }
    }
}


# API Balance

resource "azurerm_service_plan" "plan_balance" {
    name = "plan_balance-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    os_type = "Linux"
    sku_name = "F1"    
}

resource  "azurerm_linux_web_app" "appservice-balance" {
    name = "appserv-balance-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.plan_transaction.id
    site_config {
        always_on = false
        application_stack {
            docker_image_name = "nginx:latest"
        }
    }
}

# API transfer

resource "azurerm_service_plan" "plan_transfer" {
    name = "plan_transfer-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    os_type = "Linux"
    sku_name = "F1"    
}

resource  "azurerm_linux_web_app" "appservice-transfer" {
    name = "appserv-transfer-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.plan_transfer.id
    site_config {
        always_on = false
        application_stack {
            docker_image_name = "nginx:latest"
        }
    }
}

# API Notification

resource "azurerm_service_plan" "plan_notification" {
    name = "plan_notification-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    os_type = "Linux"
    sku_name = "F1"    
}

resource  "azurerm_linux_web_app" "appservice-notification" {
    name = "appserv-notification-northeurope"
    location = "northeurope"
    resource_group_name = azurerm_resource_group.rg.name
    service_plan_id = azurerm_service_plan.plan_transfer.id
    site_config {
        always_on = false
        application_stack {
            docker_image_name = "nginx:latest"
        }
    }
}