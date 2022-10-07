variable "account-id" {
  default     = ""
  type        = string
  description = "Provide the AWS account ID where the resources are going to to deploy."
}

variable "role-id" {
  default     = ""
  type        = string
  description = "Provide the AWS role ID which having the required permission for the resources to be deployed."
}

variable "app_name" {
  description = "Name of the application. Should be DNS legal. Convention is lower case with dashes - e.g. 'rogers-sms'"
  type        = string
}

variable "app_clients" {
  description = "A list of app clients to create for the application. Currently, every app_client is granted access to every scope"
  type        = list(any)
  default     = [""]
}

//for Cognito advanced security usage
variable "advanced_security_mode_enable" {
  description = "one of OFF/AUDIT/ENFORCED advanced security mode under Cognito pool"
  type        = string
}

//Message customization
variable "email_sending_account_value" {
  description = "email sending account COGNITO_DEFAULT or DEVELOPER"
  type        = string
  default     = "COGNITO_DEFAULT"
}

variable "reply_to_email_address_value" {
  description = "reply to email address in email configuration under Cognito Advanced Secruity"
  type        = string
  default     = null
}

variable "from_email_address_value" {
  description = "from email address in email comfiguration under Cognito Advanced Secruity"
  type        = string
  default     = null
}

variable "source_arn_value" {
  description = "source arn in email comfiguration under Cognito Advanced Secruity"
  type        = string
  default     = null
}

variable "heroku_app" {
  description = "heroku application name example - sample-app-sandbox"
  type        = string
}

variable "explicit_auth_flows" {
  description = "Options for auth flow (options: ADMIN_NO_SRP_AUTH, CUSTOM_AUTH_FLOW_ONLY, USER_PASSWORD_AUTH, ALLOW_ADMIN_USER_PASSWORD_AUTH, ALLOW_CUSTOM_AUTH, ALLOW_USER_PASSWORD_AUTH, ALLOW_USER_SRP_AUTH, ALLOW_REFRESH_TOKEN_AUTH)"
  type = list
  default = ["ALLOW_ADMIN_USER_PASSWORD_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH", "ALLOW_USER_SRP_AUTH"]
}

variable "mfa_configuration" {
  description = "(Optional) Multi-Factor Authentication (MFA) configuration for the User Pool"
  type        = string
  default     = "OFF"
}

######## Tagging Variables ##############################

variable "data-classification" {
  default     = "restricted"
  type        = string
  description = "Please specify the DataClassification type"

  validation {
    condition     = contains(["restricted", "confidential", "internal", "public"], var.data-classification)
    error_message = "Argument \"data-classification\" must be \"restricted\" or \"confidential\" or \"internal\" or \"public\" ."
  }
}

variable "environment" {
  default     = ""
  type        = string
  description = "Please enter the Environment type"

  validation {
    condition     = contains(["sandbox", "qa", "dev", "ss", "rss", "staging", "prd", "dscworkstation", "dscproduction"], var.environment)
    error_message = "Argument \"environment\" must be one of \"sandbox\", \"qa\", \"ss\", \"rss\", \"staging\",  \"prd\", \"dscworkstation\", \"dscproduction\" ."
  }
}

variable "application-id" {
  default     = "1234"
  type        = string
  description = "Please enter the Application ID"

  validation {
    condition     = can(regex("^[0-9]{4}$", var.application-id))
    error_message = "Please enter the valid application-id."
  }
}

variable "application-owner" {
  default     = ""
  type        = string
  description = "Please enter Email ID of the owner or domain/username or service account"

  validation {
    condition     = can(regex("^[A-Z0-9a-z._%+-]+@rci.rogers.com$", var.application-owner))
    error_message = "Please enter the valid  mail ID of the application owner or domain/username or service account."
  }
}

variable "application-role" {
  default     = "app"
  type        = string
  description = "Please enter the Application Role"

  validation {
    condition     = contains(["database", "web", "app"], var.application-role)
    error_message = "Argument \"application-role\" must be \"database\" or \"web\" or \"app\"."
  }
}

variable "SCOA" {
  default     = "123.1234.1234.1234.12345"
  type        = string
  description = "Please enter the SCOA"

  validation {
    condition     = can(regex("^[0-9]{3}[.][0-9]{4}[.][0-9]{4}[.][0-9]{4}[.][0-9]{5}$", var.SCOA))
    error_message = "Please enter the valid SCOA ID."
  }
}

variable "project-id" {
  default     = "123456"
  type        = string
  description = "Please enter the ProjectID ID"

  validation {
    condition     = can(regex("^[0-9]{6}$", var.project-id))
    error_message = "Please enter the valid 6 digit project-id."
  }
}

variable "PII" {
  default = "NO"
  type    = string

  validation {
    condition     = contains(["NO", "YES"], var.PII)
    error_message = "Argument \"PII\" must be \"NO\" or \"YES\"."
  }
}

variable "compliance" {
  default = "None"
  type    = string

  validation {
    condition     = contains(["None", "PCI", "SOX", "SOX and PCI"], var.compliance)
    error_message = "Argument \"compliance\" must be \"None\" or \"PCI\" or \"SOX\" or \"SOX and PCI\"."
  }
}


variable "application-name" {
  default     = ""
  type        = string
  description = "Application name that will use the S3 bucket (Value must be lowercase alphanumeric (can include hyphens)"

  validation {
    condition     = can(regex("[a-z0-9-]+", var.application-name))
    error_message = "Value must be lowercase alphanumeric (can include hyphens)."
  }
}

variable "businessunit" {
  default     = ""
  type        = string
  description = "Provide the businessunit Name"
}

variable "TFE" {
  default = "YES"
  type    = string

  validation {
    condition     = contains(["YES"], var.TFE)
    error_message = "Argument \"TFE\" must be \"YES\"."
  }
}
