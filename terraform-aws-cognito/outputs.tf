output "cognito_user_pool_id" {
  value = aws_cognito_user_pool.pool.id
}

output "cognito_cns_app_client_id" {
  value = aws_cognito_user_pool_client.cns_app_client.id
}

output "cognito_cns_app_client_client_secret" {
  value     = aws_cognito_user_pool_client.cns_app_client.client_secret
  sensitive = true
}

output "cognito_user_pool_JWKS_URL" {
  value = "https://${aws_cognito_user_pool.pool.endpoint}/.well-known/jwks.json"
}

output "cognito_user_pool_OAUTH_URL" {
  # TODO - Parameterize region
  value = "https://${aws_cognito_user_pool_domain.domain.domain}.auth.us-east-1.amazoncognito.com/oauth2/token"
}
