module AlfrescoBcmUtils
  class ActualizacionConfiguracion

    def initialize(tipo_configuracion)
      @tipo_configuracion = tipo_configuracion
    end

    def actualizar(parametro, valor)
      c = case @tipo_configuracion
          when 'alfresco'
            ConfiguracionAlfresco.first
          when 'correo'
            ConfiguracionCorreo.first
          end
      c.update_attribute(parametro.downcase, valor)
      puts "\n* Actualización efectuada *\n\n"
    rescue => e
      puts "\nERROR: No fué posible efectuar la actualización. Verifique el nombre correcto del parámetro de acuerdo al tipo de configuración"
      puts "\nDETALLE: \n#{e.message}\n\n"
    end

  end
end
