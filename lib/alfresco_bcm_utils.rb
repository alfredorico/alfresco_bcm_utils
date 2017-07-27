require 'cmis-ruby'
require 'terminal-table'
require 'sqlite3'
require 'yaml'
require 'ostruct'
require 'erb'
require 'ntlm/smtp'
require 'mail'
require 'pp'
require 'uri'
require 'date'
require 'active_record'
require "alfresco_bcm_utils/version"
require "alfresco_bcm_utils/db"
require "alfresco_bcm_utils/configuracion_correo"
require "alfresco_bcm_utils/servicio_correo"
require "alfresco_bcm_utils/configuracion_alfresco"
require "alfresco_bcm_utils/alfresco"
require "alfresco_bcm_utils/notificacion_documento"
require "alfresco_bcm_utils/documento"
require "alfresco_bcm_utils/listado_documentos"
require "alfresco_bcm_utils/actualizacion_configuracion"
require "alfresco_bcm_utils/listado_configuracion"

module AlfrescoBcmUtils
  def self.procesar_parametros(parametros)
    if parametros.empty?
      puts "Debe suministrar las opciones. Ejecute: notificador_alfresco -h"
      return
    end
    if parametros[:modo]
      case parametros[:modo]
      when :prueba_correo
        documento = ListadoDocumentos.obtener_documentos.sample
        argumentos = {
          documento: documento,
          subject: "Prueba de envío de correo / Documento de prueba: #{documento.nombre}",
          mensaje_notificacion: "Selección aleatoria de un documento del repositorio para los efectos de validar el funcionamiento de envío de correos electrónicos"
        }
        NotificacionDocumento.new(argumentos).enviar_correo
      when :listar_documentos_todos
        ListadoDocumentos.listado_documentos_todos
      when :listar_documentos_vencidos
        ListadoDocumentos.listado_documentos_vencidos
      when :listar_documentos_vigentes
        ListadoDocumentos.listado_documentos_vigentes
      when :listar_documentos_sin_vigencia
        ListadoDocumentos.listado_documentos_sin_vigencia
      when :listar_documentos_por_vencerse
        ListadoDocumentos.listado_documentos_por_vencerse
      when :notificar_documentos_vencidos
        puts "Enviando notificaciones de correo electrónico: "
        puts "----------------------------------------------\n "
        puts "Documentos por vencerse:"
        ListadoDocumentos.documentos_por_vencerse.each do |documento|
          puts "Documento: #{documento.nombre} - Destinatario: #{documento.destinatarios}"
          puts "Enviando ..."
          argumentos = {
            documento: documento,
            subject: "Notificación de próximo vencimiento del documento  #{documento.nombre}",
            mensaje_notificacion: "El siguiente documento se vencerá dentro de #{documento.dias_para_vencerse_a_partir_de_hoy} días. "+
                                  "Por favor efectuar las gestiones de la actualización previo a su vencimiento"
          }
          NotificacionDocumento.new(argumentos).enviar_correo
        end

        puts "\n Documentos vencidos:"
        ListadoDocumentos.documentos_vencidos.each do |documento|
          puts "Documento: #{documento.nombre} - Destinatario: #{documento.destinatarios}"
          puts "Enviando ..."
          argumentos = {
            documento: documento,
            subject: "Notificación de documento vencido #{documento.nombre}",
            mensaje_notificacion: "El siguiente documento se venció en la fecha #{documento.fecha_vencimiento.strftime("%d/%m/%Y")}. "+
                                  "Por favor efectuar las gestiones para su actualización"
          }
          NotificacionDocumento.new(argumentos).enviar_correo
        end
      end
    elsif parametros[:listar_configuracion]
      ListadoConfiguracion.new(parametros[:listar_configuracion]).listar
    elsif parametros[:actualizar_configuracion]
      ActualizacionConfiguracion.new(parametros[:actualizar_configuracion]).actualizar(parametros[:parametro], parametros[:valor])
    end
  end
end
