# Naming convention
module "naming" {
  source = "git::ssh://ProdNGAHR@vs-ssh.visualstudio.com/v3/ProdNGAHR/GT%20Cloud/terraform-azurerm-naming?ref=solution"
  suffix = var.name
}

resource "azurerm_api_management" "apim" {
  name                = module.naming.api_management.name
  location            = var.location
  resource_group_name = var.resource_group_name

  publisher_name  = var.publisher_name
  publisher_email = var.publisher_email
  sku_name        = var.sku_name

  tags = try(var.tags, null)

  virtual_network_type = try(var.settings.virtual_network_configuration.type, null)

  dynamic "virtual_network_configuration" {
    for_each = try(var.settings.virtual_network_configuration.type, null) == null ? [] : [1]
    content {
      subnet_id = try(var.settings.virtual_network_configuration.subnet_id, null)
    }
  }

  dynamic "additional_location" {
    for_each = try(var.settings.additional_locations, null) == null ? {} : var.settings.additional_locations
    content {
      location = try(additional_location.value.location, null)
      dynamic "virtual_network_configuration" {
        for_each = try(var.settings.virtual_network_configuration.type, null) == null ? [] : [1]
        content {
          subnet_id = try(additional_location.value.subnet_id, null)
        }
      }
    }
  }

  sign_in {
    enabled = try(var.settings.sign_in.enabled, false)
  }

  sign_up {
    enabled = try(var.settings.sign_up.enabled, false)
    terms_of_service {
      consent_required = try(var.settings.sign_up.terms_of_service.consent_required, false)
      enabled          = try(var.settings.sign_up.terms_of_service.enabled, false)
      text             = try(var.settings.sign_up.terms_of_service.text, "")
    }
  }

  dynamic "hostname_configuration" {
    for_each = try(var.settings.hostname_configurations, null) == null ? [] : [1]

    content {
      dynamic "management" {
        for_each = try(var.settings.hostname_configurations.management, {})

        content {
          host_name                    = management.value.host_name
          key_vault_id                 = try(management.value.key_vault_id, null)
          certificate                  = try(management.value.certificate, null)
          certificate_password         = try(management.value.certificate_password, null)
          negotiate_client_certificate = try(management.value.negotiate_client_certificate, false)
        }
      }

      dynamic "portal" {
        for_each = try(var.settings.hostname_configurations.portal, {})

        content {
          host_name                    = portal.value.host_name
          key_vault_id                 = try(portal.value.key_vault_id, null)
          certificate                  = try(portal.value.certificate, null)
          certificate_password         = try(portal.value.certificate_password, null)
          negotiate_client_certificate = try(portal.value.negotiate_client_certificate, false)
        }
      }

      dynamic "developer_portal" {
        for_each = try(var.settings.hostname_configurations.developer_portal, {})

        content {
          host_name                    = developer_portal.value.host_name
          key_vault_id                 = try(developer_portal.value.key_vault_id, null)
          certificate                  = try(developer_portal.value.certificate, null)
          certificate_password         = try(developer_portal.value.certificate_password, null)
          negotiate_client_certificate = try(developer_portal.value.negotiate_client_certificate, false)
        }
      }

      dynamic "scm" {
        for_each = try(var.settings.hostname_configurations.scm, {})

        content {
          host_name                    = scm.value.host_name
          key_vault_id                 = try(scm.value.key_vault_id, null)
          certificate                  = try(scm.value.certificate, null)
          certificate_password         = try(scm.value.certificate_password, null)
          negotiate_client_certificate = try(scm.value.negotiate_client_certificate, false)
        }
      }

      dynamic "proxy" {
        for_each = try(var.settings.hostname_configurations.proxy, {})

        content {
          host_name                    = proxy.value.host_name
          default_ssl_binding          = try(proxy.value.default_ssl_binding, false)
          key_vault_id                 = try(proxy.value.key_vault_id, null)
          certificate                  = try(proxy.value.certificate, null)
          certificate_password         = try(proxy.value.certificate_password, null)
          negotiate_client_certificate = try(proxy.value.negotiate_client_certificate, false)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = try(var.settings.identity, null) == null ? [] : [1]

    content {
      type         = var.settings.identity.type
      identity_ids = try(var.settings.identity.identity_ids, null)
    }
  }

  notification_sender_email = try(var.settings.notification_sender_email, null)

  dynamic "policy" {
    for_each = try(var.settings.policy, null) == null ? [] : [1]

    content {
      xml_content = fileexists(try(var.settings.policy.from_file_path, false)) != false ? file(var.settings.policy.from_file_path) : try(var.settings.policy.xml_content, null)
      xml_link    = try(var.settings.policy.xml_link, null)
    }
  }

  dynamic "protocols" {
    for_each = try(var.settings.protocols, null) == null ? [] : [1]

    content {
      enable_http2 = try(var.settings.protocols.enable_http2, false)
    }
  }

  dynamic "security" {
    for_each = try(var.settings.security, null) == null ? [] : [1]

    content {
      enable_backend_ssl30  = try(var.settings.security.enable_backend_ssl30, null)
      enable_backend_tls10  = try(var.settings.security.enable_backend_tls10, null)
      enable_backend_tls11  = try(var.settings.security.enable_backend_tls11, null)
      enable_frontend_ssl30 = try(var.settings.security.enable_frontend_ssl30, null)
      enable_frontend_tls10 = try(var.settings.security.enable_frontend_tls10, null)
      enable_frontend_tls11 = try(var.settings.security.enable_frontend_tls11, null)

      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = try(var.settings.security.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled, null)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = try(var.settings.security.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled, null)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = try(var.settings.security.tls_ecdheRsa_with_aes128_cbc_sha_ciphers_enabled, null)
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = try(var.settings.security.tls_ecdheRsa_with_aes256_cbc_sha_ciphers_enabled, null)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = try(var.settings.security.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled, null)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = try(var.settings.security.tls_rsa_with_aes128_cbc_sha_ciphers_enabled, null)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = try(var.settings.security.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled, null)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = try(var.settings.security.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled, null)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = try(var.settings.security.tls_rsa_with_aes256_cbc_sha_ciphers_enabled, null)

      enable_triple_des_ciphers  = try(var.settings.security.enable_triple_des_ciphers, null)
      triple_des_ciphers_enabled = try(var.settings.security.triple_des_ciphers_enabled, null)

      /* disable_backend_ssl30  = try(var.settings.security.disable_backend_ssl30, null)
      disable_backend_tls10  = try(var.settings.security.disable_backend_tls10, null)
      disable_backend_tls11  = try(var.settings.security.disable_backend_tls11, null)
      disable_frontend_ssl30 = try(var.settings.security.disable_frontend_ssl30, null)
      disable_frontend_tls10 = try(var.settings.security.disable_frontend_tls10, null)
      disable_frontend_tls11 = try(var.settings.security.disable_frontend_tls11, null) */
    }
  }
}