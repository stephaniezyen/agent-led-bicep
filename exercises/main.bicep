// ============================================================
// Bicep 101 - Exercises
// ============================================================
//
// Resource syntax:
//   resource <symbolicName> '<resourceType>@<apiVersion>' = { ... }
//
// A storage account needs these properties:
//   name:     globally unique, 3-24 chars, lowercase letters and numbers only
//   location: where in Azure to create it (hint: resourceGroup().location)
//   sku:      object with a 'name' property (e.g., 'Standard_LRS')
//   kind:     the type of storage account (e.g., 'StorageV2')
//
// Resource type: Microsoft.Storage/storageAccounts

// Write your resource below:
