/*ストレージアカウント*/
resource "azurerm_storage_account" "storagebase01" {
name = var.storage-name-base
resource_group_name = var.rg-name-hub
location = var.rg-location
account_tier = "Standard"
account_replication_type = "GRS"

network_rules {
  default_action = "Deny"
  virtual_network_subnet_ids = ["${azurerm_subnet.vnet-01-subnet.id}"]
}

allow_blob_public_access = false
is_hns_enabled = false
min_tls_version = "TLS1_0"


tags = {
    ProjectName = "Base" 
}

}

/*ライフサイクルポリシー*/
resource "azurerm_storage_management_policy" "storage-account-lifecycle-management-policy" {
  storage_account_id= azurerm_storage_account.storagebase01.id
  rule {
    name= "archive"
    enabled= true
    filters {
      blob_types= ["blockBlob"]
    }
    actions {
      base_blob {
        tier_to_archive_after_days_since_modification_greater_than= 1095
      }
    }
  }
}


/*ストレージアカウント*/
resource "azurerm_storage_account" "storagebase02" {
name = "${var.storage-name-base}cool"
resource_group_name = var.rg-name-hub
location = var.rg-location
account_tier = "Standard"
account_replication_type = "GRS"
access_tier = "cool"

network_rules {
  default_action = "Deny"
  virtual_network_subnet_ids = ["${azurerm_subnet.vnet-01-subnet.id}"]
}

allow_blob_public_access = false
is_hns_enabled = false
min_tls_version = "TLS1_0"


tags = {
    ProjectName = "Base" 
}

}
