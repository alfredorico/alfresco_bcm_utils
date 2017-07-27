# Documentos vencidos al día de hoy Date.today
module AlfrescoBcmUtils
  module ListadoDocumentos
    extend self
    def obtener_documentos
      documentos = Array.new
      query = Alfresco.repositorio.query <<-QUERY
        select d.*, o.* from cmis:document as d join bod:metadatabcm as o on d.cmis:objectId = o.cmis:objectId order by d.cmis:name
      QUERY
      query.each_result(limit: :all) do |document|
        documento = Documento.new( nombre: document.properties["d.cmis:name"],
                                   descripcion: document.properties["d.cmis:description"],
                                   url: "https://#{ConfiguracionAlfresco.ip}/share/page/dp/ws/faceted-search#searchTerm=#{URI.escape(document.properties["d.cmis:name"])}&scope=repo&sortField=null",
                                   email_responsable: document.properties["o.bod:email_responsable"],
                                   nombre_responsable: document.properties["o.bod:nombre_responsable"],
                                   documentos_relacionados: document.properties["o.bod:documentos_relacionados"],
                                   cantidad_meses_vigencia: document.properties["o.bod:cantidad_meses_vigencia"],
                                   fecha_ultima_actualizacion: document.properties["o.cmis:lastModificationDate"]
                                 )
        documentos << documento
      end
      documentos
    end

    def documentos_vencidos
      obtener_documentos.select{|d| d.cantidad_meses_vigencia != 0 and d.vencido? }
    end

    def documentos_por_vencerse
      obtener_documentos.select{|d| d.cantidad_meses_vigencia != 0 and d.por_vencerse? }
    end    
    
    def listado_documentos_todos
      reporte(obtener_documentos)
    end

    def listado_documentos_sin_vigencia
      reporte(obtener_documentos.select{|d| d.cantidad_meses_vigencia == 0})
    end

    def listado_documentos_vigentes
      reporte(obtener_documentos.select{|d| d.cantidad_meses_vigencia != 0 and d.vigente? })
    end

    def listado_documentos_vencidos
      reporte(documentos_vencidos)
    end

    def listado_documentos_por_vencerse
      reporte(documentos_por_vencerse)
    end

    private
    def reporte(documentos)
      table = Terminal::Table.new :headings => ['NOMBRE', 'EMAIL RESPONSABLE', 'ÚLTIMA ACTUALIZACIÓN', 'VIGENCIA','VENCIMIENTO'], :style => {:all_separators => true},
                                  :rows => documentos.map {|d| [d.nombre, d.email_responsable, d.fecha_ultima_actualizacion.strftime("%d/%m/%Y"), d.cantidad_meses_vigencia_texto, d.fecha_vencimiento.strftime("%d/%m/%Y")] }
      puts table
      puts "TOTAL DE DOCUMENTOS LISTADOS: #{documentos.size}"
    end

  end
end


#destinatarios = [ParametrosAlfresco.destinatario_notificacion]
#Alfresco.repositorio.query("SELECT cm:email FROM cm:person where cm:userName in ('#{document.properties["d.cmis:createdBy"]}','#{document.properties["d.cmis:lastModifiedBy"]}')").each_result do |p|
#  p.properties["cm:email"].each do |correo| # p.properties["cm:email"] contiene un arreglo con a lo más dos direcciones de email,
#    destinatarios << correo                 # una dirección es la del creador y la otra es la del autor de la última actualización
#  end
#end
#documento.destinatarios = destinatarios
