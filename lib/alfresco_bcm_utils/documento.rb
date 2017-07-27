# Documentos vencidos al día de hoy hoy
module AlfrescoBcmUtils
  class Documento
    attr_reader :nombre, :descripcion, :url, :email_responsable, :nombre_responsable,
                :documentos_relacionados, :cantidad_meses_vigencia, :fecha_ultima_actualizacion

    def initialize(argumentos)
      @nombre = argumentos.fetch(:nombre)
      @descripcion = argumentos.fetch(:descripcion)
      @email_responsable = argumentos.fetch(:email_responsable)
      @nombre_responsable = argumentos.fetch(:nombre_responsable)
      @documentos_relacionados = argumentos.fetch(:documentos_relacionados)
      @cantidad_meses_vigencia = (argumentos.fetch(:cantidad_meses_vigencia)).to_i
      @fecha_ultima_actualizacion = argumentos.fetch(:fecha_ultima_actualizacion).to_date
    end
    
    def destinatarios
      [@email_responsable, ConfiguracionAlfresco.destinatario_notificacion].join(',')
    end

    def fecha_vencimiento
      fecha_ultima_actualizacion >> cantidad_meses_vigencia
    end

    def vigente?
      ( fecha_ultima_actualizacion >> cantidad_meses_vigencia ) > hoy
    end

    def vencido?
      !vigente?
    end

    def por_vencerse?
      # Si faltan 21 días o menos para la fecha del vencimiento, entonces el documento está por vencerse
      dias_para_vencerse_a_partir_de_hoy >= 1 and dias_para_vencerse_a_partir_de_hoy <= ConfiguracionAlfresco.dias_para_vencer_documento
    end

    def dias_para_vencerse_a_partir_de_hoy
      ((fecha_ultima_actualizacion >> cantidad_meses_vigencia) - hoy).to_int if fecha_ultima_actualizacion
    end

    def url
      "https://#{ConfiguracionAlfresco.ip}/share/page/dp/ws/faceted-search#searchTerm=#{URI.escape(nombre)}&scope=repo&sortField=null"
    end

    def cantidad_meses_vigencia_texto
      cantidad_meses_vigencia != 0 ? "#{cantidad_meses_vigencia} meses" : nil
    end

    def fecha_ultima_actualizacion
      @fecha_ultima_actualizacion
    end

    def hoy
      Date.today
    end

  end
end
