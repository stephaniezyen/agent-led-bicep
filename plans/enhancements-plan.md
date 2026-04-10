# Bicep 101 Tutorial — Enhancements Plan

## Strong Fits for the Curriculum

### 1. Loops (`for` expressions)
Deploy N resources from an array or range. Currently not covered at all — this is a fundamental Bicep concept.
- **PowerShell bridge:** `foreach` / `ForEach-Object`
- **Suggested placement:** Between current Modules 2 (Params & Variables) and 3 (Modules & Outputs)
- **Exercise idea:** Create multiple storage accounts from an array of names/configs

### 2. User-Defined Types (`type` keyword)
Define reusable schemas for params, variables, and outputs. Brings compile-time validation.
- **PowerShell bridge:** `[PSCustomObject]` type definitions, class definitions
- **Suggested placement:** Alongside or right after loops
- **Exercise idea:** Define a `StorageConfig` type with constrained properties, use it as a parameter

### 3. User-Defined Functions
Reusable expressions within Bicep files for common logic.
- **PowerShell bridge:** `function Get-Something { ... }`
- **Suggested placement:** Pairs well with the existing modules concept (Module 3)
- **Exercise idea:** Create a naming convention function used across multiple resources

## Ideas for Future Additions

### 4. `@secure()` Decorator
Handling secrets safely — every real-world deployment needs this. Pairs naturally with Key Vault references.
- **Exercise idea:** Add a secure param for a storage account SAS token or Key Vault secret URI

### 5. Conditions (`if` on resources)
Deploy a resource only when a condition is true — e.g. only create a diagnostic setting in prod.
- **PowerShell bridge:** `if ($env -eq 'prod') { ... }`
- **Exercise idea:** Conditionally deploy a diagnostic storage account based on the `environment` param

### 6. `existing` keyword
Reference resources that already exist in Azure without redeploying them — e.g. an existing Key Vault or VNet.
- **Exercise idea:** Reference an existing Key Vault and pull a secret URI into an output

### 7. `.bicepparam` Files
Structured parameter files as an alternative to passing `--parameters` flags at deploy time.
- **Exercise idea:** Create `dev.bicepparam` and `prod.bicepparam` for the Module 2 template
