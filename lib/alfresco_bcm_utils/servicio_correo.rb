# Este archivo debe ser cargado por la gema luego del archivo parametros_correo.rb

Mail.defaults do
  delivery_method :smtp, {
    :address => AlfrescoBcmUtils::ConfiguracionCorreo.servidor_smtp,
    :port => AlfrescoBcmUtils::ConfiguracionCorreo.puerto,
    :user_name => AlfrescoBcmUtils::ConfiguracionCorreo.cuenta_correo,
    :password => AlfrescoBcmUtils::ConfiguracionCorreo.password,
    :authentication => AlfrescoBcmUtils::ConfiguracionCorreo.tipo_autenticacion,
    :enable_starttls_auto => AlfrescoBcmUtils::ConfiguracionCorreo.tls?,
    :openssl_verify_mode => "none"
  }
end
