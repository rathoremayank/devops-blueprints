# Terraform Learning Material

## 1. Important Concepts

### Provider
A provider is a plugin that Terraform uses to interact with APIs of cloud platforms and services (e.g., AWS, Azure, GCP). Providers are specified in the configuration and must be initialized before use.

**Example:**
```hcl
provider "aws" {
  region = "us-west-2"
}
```

### Variables
Variables allow you to parameterize your Terraform configurations. They can be defined in `.tf` files or passed via CLI, environment variables, or `.tfvars` files.

**Example:**
```hcl
variable "instance_type" {
  description = "Type of EC2 instance"
  default     = "t2.micro"
}
```

### Outputs
Outputs are used to display values after Terraform applies a configuration. Useful for sharing data between modules or with users.

**Example:**
```hcl
output "instance_ip" {
  value = aws_instance.example.public_ip
}
```

### Provisioner & Provisioner Types
Provisioners execute scripts or commands on resources after creation. Types include `local-exec` and `remote-exec`.

**Example:**
```hcl
resource "aws_instance" "example" {
  # ...existing code...
  provisioner "remote-exec" {
    inline = ["sudo apt-get update"]
  }
}
```

### tfvars
`.tfvars` files are used to set variable values separately from the main configuration.

**Example:**
```hcl
instance_type = "t2.large"
```

---

## 2. Terraform State File
Terraform maintains a state file (`terraform.tfstate`) to track resources it manages. This file is critical for resource mapping and change detection.

**Best Practices:**
- Never edit manually
- Secure the file (contains sensitive data)
- Use remote backends for collaboration

---

## 3. Remote State and State Locking
Remote state stores the state file in a shared location (e.g., S3, Azure Blob). State locking prevents concurrent modifications.

**Example (S3 backend):**
```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-west-2"
    dynamodb_table = "terraform-lock"
  }
}
```

---

## 4. Importing Existing Infrastructure
Terraform can import existing resources using the `terraform import` command.

**Example:**
```sh
terraform import aws_instance.example i-1234567890abcdef0
```

---

## 5. Terragrunt
Terragrunt is a thin wrapper for Terraform that provides extra tools for managing configurations, DRY principles, and remote state.

**Example:**
```hcl
# terragrunt.hcl
remote_state {
  backend = "s3"
  config = {
    bucket = "my-terraform-state"
    key    = "global/s3/terraform.tfstate"
    region = "us-west-2"
  }
}
```

---

## 6. Drift Detection and Managing Drifts
Drift occurs when infrastructure changes outside Terraform. Use `terraform plan` to detect drifts. Some tools (e.g., Atlantis, Terraform Cloud) offer automated drift detection.

**Managing Drifts:**
- Regularly run `terraform plan`
- Use automation for detection
- Reconcile manually or with `terraform apply`

---

## 7. Modular Terraform Setup
Modules allow you to reuse and organize Terraform code. Modules can be local or remote.

**Example:**
```hcl
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "my-vpc"
  cidr   = "10.0.0.0/16"
}
```

---

## 8. Sensitive Data and Vault Integration
Sensitive data (e.g., secrets, passwords) should be managed securely. Use `sensitive = true` for outputs and integrate with HashiCorp Vault for secret management.

**Example:**
```hcl
output "db_password" {
  value     = var.db_password
  sensitive = true
}
```

**Vault Integration:**
- Use Vault provider
- Fetch secrets dynamically

---

# Scenario-Based Interview Questions & Answers

## Provider

**1. Q:** How do you configure multiple providers in a single Terraform project?
- **A:** Define each provider block with an alias and reference the alias in resources.


**2. Q:** What happens if you change the provider version?
- **A:** Terraform may require reinitialization and could affect resource compatibility.


**3. Q:** How do you authenticate to a cloud provider?
- **A:** Use environment variables, credentials files, or provider-specific authentication blocks.


**4. Q:** Can you use a provider for a private API?
- **A:** Yes, by writing a custom provider or using an existing one if available.


**5. Q:** What is provider initialization?
- **A:** The process where Terraform downloads and configures provider plugins.


**6. Q:** How do you restrict provider usage to specific modules?
- **A:** Use provider aliasing and pass the provider explicitly to modules.


**7. Q:** What is the impact of provider deprecation?
- **A:** May require migration to a supported provider or refactoring code.


**8. Q:** How do you handle provider credentials securely?
- **A:** Use environment variables, secret managers, or Vault integration.


**9. Q:** Can you use multiple versions of a provider?
- **A:** Not in the same configuration, but possible across workspaces or projects.


**10. Q:** How do you debug provider issues?
- **A:** Enable detailed logging and check provider documentation.


## Variables
**1. Q:** How do you pass variables at runtime?
- **A:** Use `-var` or `-var-file` flags with `terraform apply` or `plan`.


**2. Q:** What is the difference between default and required variables?
- **A:** Default variables have a value; required variables must be provided.


**3. Q:** How do you validate variable values?
- **A:** Use the `validation` block in variable definitions.


**4. Q:** Can you use complex types for variables?
- **A:** Yes, such as lists, maps, and objects.


**5. Q:** How do you reference variables in modules?
- **A:** Pass them as arguments in the module block.


**6. Q:** What is a `.tfvars` file?
- **A:** A file for setting variable values outside the main configuration.


**7. Q:** How do you handle sensitive variables?
- **A:** Mark them as sensitive and avoid outputting them.


**8. Q:** Can you override variable values?
- **A:** Yes, using CLI flags, environment variables, or `.tfvars` files.


**9. Q:** How do you document variables?
- **A:** Use the `description` attribute in variable blocks.


**10. Q:** How do you use environment variables for Terraform variables?
- **A:** Prefix with `TF_VAR_` (e.g., `TF_VAR_instance_type`).


## Outputs
1. **Q:** What is the purpose of outputs?
- **A:** To expose resource attributes after apply.


**2. Q:** How do you use outputs in modules?
- **A:** Reference them as `module.<name>.<output>`.


**3. Q:** Can outputs be marked as sensitive?
- **A:** Yes, using `sensitive = true`.


**4. Q:** How do you consume outputs in automation?
- **A:** Use `terraform output` command or integrate with CI/CD.


**5. Q:** Can outputs reference resources from other modules?
- **A:** Yes, if the module exposes them.


**6. Q:** How do you output a list or map?
- **A:** Define the output value as a list or map.


**7. Q:** What happens if an output references a destroyed resource?
- **A:** Terraform will error during apply or output.


**8. Q:** How do you use outputs for cross-stack communication?
- **A:** Store outputs in remote state and read them in other stacks.


**9. Q:** Can outputs be used in provisioners?
- **A:** Yes, by referencing them in provisioner scripts.


**10. Q:** How do you format output values?
- **A:** Use interpolation and formatting functions.


## Provisioner & Provisioner Types
1. **Q:** What is the difference between `local-exec` and `remote-exec`?
- **A:** `local-exec` runs on the machine executing Terraform; `remote-exec` runs on the target resource.


**2. Q:** When should you use provisioners?
- **A:** For bootstrapping or configuration tasks not handled by resource arguments.


**3. Q:** What are the risks of using provisioners?
- **A:** Non-idempotency, dependency on external systems, and error handling.


**4. Q:** How do you pass variables to provisioners?
- **A:** Use interpolation syntax in provisioner blocks.


**5. Q:** Can you use provisioners with all resources?
- **A:** Only with resources that support them.


**6. Q:** How do you handle provisioner failures?
- **A:** Use `on_failure` argument to control behavior.


**7. Q:** What is a connection block?
- **A:** Defines how Terraform connects to the resource for remote-exec.


**8. Q:** Can you chain multiple provisioners?
- **A:** Yes, by defining multiple provisioner blocks.


**9. Q:** How do you debug provisioner scripts?
- **A:** Enable verbose logging and check resource logs.


**10. Q:** What alternatives exist to provisioners?
- **A:** Use configuration management tools (e.g., Ansible, Chef).


## tfvars
1. **Q:** How do you use multiple `.tfvars` files?
- **A:** Pass multiple `-var-file` flags to Terraform.


**2. Q:** Can `.tfvars` files contain sensitive data?
- **A:** Yes, but it's best to secure them and avoid version control.


**3. Q:** How do you structure `.tfvars` files for environments?
- **A:** Create separate files for each environment (e.g., `dev.tfvars`, `prod.tfvars`).


**4. Q:** Can you use JSON for `.tfvars`?
- **A:** Yes, Terraform supports JSON-formatted variable files.


**5. Q:** How do you override default variable values?
- **A:** Set them in `.tfvars` files or via CLI.


**6. Q:** What is the precedence of variable values?
- **A:** CLI > `.tfvars` > environment variables > default.


**7. Q:** How do you reference `.tfvars` in automation?
- **A:** Pass them as arguments in CI/CD pipelines.


**8. Q:** Can you encrypt `.tfvars` files?
- **A:** Yes, using tools like Vault or SOPS.


**9. Q:** How do you validate `.tfvars` values?
- **A:** Use variable validation blocks.


**10. Q:** How do you document `.tfvars` usage?
- **A:** Provide README or comments in the files.


## Terraform State File
1. **Q:** What information is stored in the state file?
- **A:** Resource mappings, metadata, outputs, and dependencies.


**2. Q:** Why should you avoid manual edits to the state file?
- **A:** It can corrupt the state and break resource tracking.


**3. Q:** How do you recover a lost state file?
- **A:** Restore from backup or remote backend.


**4. Q:** Can you split state files?
- **A:** Yes, using workspaces or separate backends.


**5. Q:** How do you secure the state file?
- **A:** Use encryption and restrict access.


**6. Q:** What is state locking?
- **A:** Prevents concurrent modifications to the state file.


**7. Q:** How do you inspect the state file?
- **A:** Use `terraform state` commands.


**8. Q:** Can you migrate state files?
- **A:** Yes, using `terraform state mv` and backend migration.


**9. Q:** How do you handle state file conflicts?
- **A:** Use state locking and resolve manually if needed.


**10. Q:** What is the impact of state file loss?
- **A:** Terraform loses track of resources, risking orphaned infrastructure.


## Remote State and State Locking
1. **Q:** What are the benefits of remote state?
- **A:** Collaboration, security, and backup.


**2. Q:** How do you enable state locking?
- **A:** Use backends that support locking (e.g., S3 with DynamoDB).


**3. Q:** What happens if state locking fails?
- **A:** Terraform errors and prevents apply until resolved.


**4. Q:** Can you use remote state across teams?
- **A:** Yes, with proper access controls.


**5. Q:** How do you migrate local state to remote?
- **A:** Configure backend and run `terraform init`.


**6. Q:** What is a backend configuration?
- **A:** Defines where and how state is stored.


**7. Q:** How do you read remote state outputs?
- **A:** Use `terraform_remote_state` data source.


**8. Q:** Can you encrypt remote state?
- **A:** Yes, most backends support encryption.


**9. Q:** How do you troubleshoot remote state issues?
- **A:** Check backend logs and Terraform error messages.


**10. Q:** What is the impact of remote state unavailability?
- **A:** Blocks Terraform operations and collaboration.


## Importing Existing Infrastructure
1. **Q:** How do you import a resource into Terraform?
- **A:** Use `terraform import` with resource type and ID.


**2. Q:** What are the limitations of `terraform import`?
- **A:** No automatic configuration generation; must write config manually.


**3. Q:** Can you import multiple resources at once?
- **A:** Use scripts or automation to batch imports.


**4. Q:** How do you verify imported resources?
- **A:** Run `terraform plan` and check state file.


**5. Q:** What happens if resource config doesn't match actual state?
- **A:** Terraform will show a diff and may require reconciliation.


**6. Q:** Can you import resources from different providers?
- **A:** Yes, as long as the provider supports import.


**7. Q:** How do you handle drift after import?
- **A:** Update configuration to match actual state.


**8. Q:** Can you import resources into modules?
- **A:** Yes, specify the module path in the import command.


**9. Q:** How do you automate imports?
- **A:** Use scripts or tools like Terraformer.


**10. Q:** What is the impact of failed imports?
- **A:** Resource is not tracked; must retry or fix config.


## Terragrunt
1. **Q:** What is Terragrunt?
- **A:** A wrapper for Terraform that simplifies configuration and state management.


**2. Q:** How does Terragrunt manage remote state?
- **A:** Uses `remote_state` blocks in `terragrunt.hcl`.


**3. Q:** Can Terragrunt manage multiple environments?
- **A:** Yes, using hierarchical configuration.


**4. Q:** How do you DRY Terraform code with Terragrunt?
- **A:** Use `include` and shared configuration blocks.


**5. Q:** What is the impact of using Terragrunt?
- **A:** Simplifies management but adds complexity to setup.


**6. Q:** How do you run Terraform commands with Terragrunt?
- **A:** Use `terragrunt apply`, `terragrunt plan`, etc.


**7. Q:** Can Terragrunt manage dependencies?
- **A:** Yes, with `dependencies` blocks.


**8. Q:** How do you structure Terragrunt repos?
- **A:** Use folders for environments and modules.


**9. Q:** Can Terragrunt be used with CI/CD?
- **A:** Yes, integrates with automation pipelines.


**10. Q:** How do you debug Terragrunt issues?
- **A:** Enable verbose logging and check documentation.


## Drift Detection and Managing Drifts
1. **Q:** What is drift in Terraform?
- **A:** Changes to infrastructure outside Terraform's control.


**2. Q:** How do you detect drift?
- **A:** Run `terraform plan` and compare with state.


**3. Q:** What tools help with drift detection?
- **A:** Terraform Cloud, Atlantis, custom scripts.


**4. Q:** How do you manage detected drift?
- **A:** Update configuration or apply changes to reconcile.


**5. Q:** Can drift be prevented?
- **A:** Use automation and restrict manual changes.


**6. Q:** What is the impact of unmanaged drift?
- **A:** Infrastructure may not match desired state, causing issues.


**7. Q:** How do you automate drift detection?
- **A:** Schedule regular `terraform plan` runs.


**8. Q:** Can drift be ignored?
- **A:** Not recommended; may lead to inconsistencies.


**9. Q:** How do you document drift management?
- **A:** Maintain logs and update configuration as needed.


**10. Q:** What is the role of state file in drift detection?
- **A:** State file is the source of truth for resource tracking.


## Modular Terraform Setup
1. **Q:** What is a Terraform module?
- **A:** A reusable collection of resources and configurations.


**2. Q:** How do you use a public module?
- **A:** Reference it in the `source` argument of a module block.


**3. Q:** Can modules have outputs?
- **A:** Yes, outputs can be exposed for use by parent modules.


**4. Q:** How do you pass variables to modules?
- **A:** As arguments in the module block.


**5. Q:** Can modules be nested?
- **A:** Yes, modules can call other modules.


**6. Q:** How do you version modules?
- **A:** Use version constraints in the `source` argument.


**7. Q:** What is the impact of module changes?
- **A:** May require reapply and can affect dependent resources.


**8. Q:** How do you test modules?
- **A:** Use example configurations and `terraform plan`.


**9. Q:** Can modules be shared across teams?
- **A:** Yes, via registries or shared repositories.


**10. Q:** How do you document modules?
- **A:** Provide README and usage examples.


## Sensitive Data and Vault Integration
1. **Q:** How do you mark outputs as sensitive?
- **A:** Use `sensitive = true` in output blocks.


**2. Q:** What is HashiCorp Vault?
- **A:** A tool for managing secrets and sensitive data.


**3. Q:** How do you integrate Vault with Terraform?
- **A:** Use the Vault provider and data sources.


**4. Q:** Can you fetch secrets dynamically?
- **A:** Yes, using Vault data sources in Terraform.


**5. Q:** How do you secure sensitive variables?
- **A:** Avoid outputting them and use secret managers.


**6. Q:** What is the impact of exposing sensitive data?
- **A:** Security risks and potential data breaches.


**7. Q:** How do you audit sensitive data usage?
- **A:** Use logging and monitoring tools.


**8. Q:** Can you rotate secrets with Terraform?
- **A:** Yes, by updating values in Vault and reapplying.


**9. Q:** How do you restrict access to sensitive outputs?
- **A:** Use RBAC and limit output exposure.


**10. Q:** How do you document sensitive data handling?
- **A:** Provide guidelines and secure practices in documentation.


---

# References
- [Terraform Official Documentation](https://www.terraform.io/docs/index.html)
- [HashiCorp Vault Documentation](https://www.vaultproject.io/docs)
- [Terragrunt Documentation](https://terragrunt.gruntwork.io/docs/)
- [Terraform Registry](https://registry.terraform.io/)
- [Terraform Best Practices](https://www.terraform.io/docs/language/best-practices.html)
