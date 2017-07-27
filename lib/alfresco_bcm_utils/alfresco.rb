module AlfrescoBcmUtils
  module Alfresco

    extend self

    def repositorio
      @@repositorio ||= servidor.repository(ConfiguracionAlfresco.nombre_repositorio)
    end

    def servidor
      CMIS::Server.new( service_url: "http://#{ConfiguracionAlfresco.ip}:#{ConfiguracionAlfresco.puerto}/alfresco/api/-default-/public/cmis/versions/1.1/browser", username: ConfiguracionAlfresco.usuario, password: ConfiguracionAlfresco.password )
    end

  end
end
