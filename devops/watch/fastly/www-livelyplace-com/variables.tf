variable "environment" {
  type        = string
  description = "The environment to deploy to: dev, prod, qa"
  validation {
    condition     = contains(["dev", "prod", "qa"], var.environment)
    error_message = "Environment must be one of dev, prod, qa"
  }
}