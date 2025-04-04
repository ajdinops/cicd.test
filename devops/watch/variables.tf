variable "account_id" {
  type        = string
  default     = "433624884903"
  sensitive   = true
  description = "AWS Account ID"
}

variable "datadog_api_url" {
  type        = string
  description = "Datadog API URL"
  default     = "https://api.datadoghq.com"
}

variable "datadog_site" {
  type        = string
  description = "Datadog Site Parameter"
  default     = "datadoghq.com"
}
