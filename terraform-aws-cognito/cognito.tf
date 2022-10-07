resource "aws_cognito_user_pool" "pool" {

  name = "${var.app_name}-${var.environment}"

  admin_create_user_config {
    allow_admin_create_user_only = false
  }

  auto_verified_attributes = ["email"]
  alias_attributes = ["email"]

  verification_message_template {
    default_email_option = "CONFIRM_WITH_CODE"
    email_message        = "Welcome to Rogers ${var.app_name} ${var.environment}! \nYour verification code is {####}."
    email_subject        = "Rogers ${var.app_name} ${var.environment}: your verification code"
    sms_message          = "Your verification code is {####}. "
  }

  user_pool_add_ons {
    advanced_security_mode = var.advanced_security_mode_enable
  }

  email_configuration {
    email_sending_account  = var.email_sending_account_value
    reply_to_email_address = var.reply_to_email_address_value
    from_email_address     = var.from_email_address_value
    source_arn             = var.source_arn_value
  }

/*
  # substitute for unused_account_validity_days = 7
  password_policy {
    temporary_password_validity_days = 7
  }
*/

  mfa_configuration = var.mfa_configuration

  # Required only if MFA is ON
  software_token_mfa_configuration {
    enabled = var.mfa_configuration == "ON" ? "true" : "false"
  }

  tags = local.common_tags
}

resource "aws_cognito_user_pool_client" "app_client" {

  for_each                             = toset(var.app_clients)
  name                                 = "${var.app_name}-${var.environment}-${each.key}-app_client"
  user_pool_id                         = aws_cognito_user_pool.pool.id
  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes                 = aws_cognito_resource_server.resource.scope_identifiers
}

resource "aws_cognito_user_pool_client" "cns_app_client" {

  name                                 = "${var.app_name}-${var.environment}-cns-app_client"
  user_pool_id                         = aws_cognito_user_pool.pool.id
  generate_secret                      = true
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_flows                  = ["client_credentials"]
  allowed_oauth_scopes                 = aws_cognito_resource_server.resource.scope_identifiers
  explicit_auth_flows                  = var.explicit_auth_flows
}

resource "aws_cognito_resource_server" "resource" {

  identifier = var.heroku_app
  name       = "${var.app_name}-${var.environment}-resource-server"

  scope {
    scope_name        = "Public"
    scope_description = "Required to support OAuth2 client implementation"
  }

  user_pool_id = aws_cognito_user_pool.pool.id
}

resource "aws_cognito_user_pool_domain" "domain" {

  domain       = "${var.app_name}-${var.environment}"
  user_pool_id = aws_cognito_user_pool.pool.id
}
