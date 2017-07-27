module AlfrescoBcmUtils
  class NotificacionDocumento
    def initialize(argumentos)
      @documento = argumentos[:documento]
      @from = argumentos.fetch(:from){'Gestión Documental BCM'}
      @subject = argumentos[:subject]
      @mensaje_notificacion = argumentos[:mensaje_notificacion]
    end

    def enviar_correo
      m = Mail.new
      m.from     "Gestion Documental BCM <#{ConfiguracionCorreo.cuenta_correo}>"
      m.to       @documento.destinatarios
      m.subject  @subject

      text_part = Mail::Part.new
      text_part.body texto_correo

      html_part = Mail::Part.new
      html_part.content_type 'text/html; charset=UTF-8'
      html_part.body html_correo

      m.text_part = text_part
      m.html_part = html_part
      m.deliver!
      puts "Enviado!"
    rescue => e
      puts "ERROR DE ENVIO: #{e.message}"
    end

    private
    def texto_correo
      <<-STRING
      NOTIFICACIÓN:
      #{@mensaje_notificacion}

      NOMBRE: #{@documento.nombre}
      DESCRIPCION: #{@documento.descripcion}
      FECHA DE VENCIMIENTO: #{@documento.fecha_vencimiento}
      URL: #{@documento.url}
      ------------------------------------------------------
      STRING
    end

    def html_correo
      <<-HTML
      <h3>NOTIFICACI&Oacute;N:</h3>
      #{@mensaje_notificacion}

      <br/><br/>
      <strong>Nombre: </strong>#{@documento.nombre}<br>
      <strong>Descriptivo: </strong>#{@documento.descripcion}<br>
      <strong>Fecha de vencimiento:</strong> #{@documento.fecha_vencimiento.try(:strftime,"%d/%m/%Y")}<br>
      <strong>URL: </strong>#{@documento.url}<br>
      ------------------------------------------------------
      HTML
    end

  end
end
