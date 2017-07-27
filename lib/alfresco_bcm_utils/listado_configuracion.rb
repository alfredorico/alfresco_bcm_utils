module AlfrescoBcmUtils
  class ListadoConfiguracion

    def initialize(tipo_configuracion)
      @tipo_configuracion = tipo_configuracion
    end

    def listar
      case @tipo_configuracion
      when :alfresco
        c = ConfiguracionAlfresco.first
        puts "\nConfiguracion Alfresco:"
        puts "----------------------- \n"
        puts "IP: #{c.ip}"
        puts "PUERTO: #{c.puerto}"
        puts "USUARIO: #{c.usuario}"
        puts "PASSWORD: *********"
        puts "DESTINATARIO_NOTIFICACION: #{c.destinatario_notificacion}"
        puts "DIAS_PARA_VENCER_DOCUMENTO: #{c.dias_para_vencer_documento} \n\n"
      when :correo
        c = ConfiguracionCorreo.first
        puts "\nConfiguracion de envío de correo electrónico:"
        puts "----------------------- \n"
        puts "SERVIDOR_SMTP: #{c.servidor_smtp}"
        puts "PUERTO: #{c.puerto}"
        puts "CUENTA_CORREO: #{c.cuenta_correo}"
        puts "PASSWORD: ********"
        puts "TIPO_AUTENTICACION: #{c.tipo_autenticacion}"
        puts "TLS: #{c.tls} \n\n"
      end

    end

  end
end
