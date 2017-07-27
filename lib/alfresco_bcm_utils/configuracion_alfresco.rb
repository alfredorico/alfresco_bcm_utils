module AlfrescoBcmUtils
  class ConfiguracionAlfresco < ActiveRecord::Base
    self.table_name = 'configuracion_alfresco'
    
    def self.ip
      first.ip if one?
    end
      
    def self.puerto
      first.puerto if one?
    end
      
    def self.url
      first.url if one?
    end
      
    def self.usuario
      first.usuario if one?
    end
      
    def self.password
      first.password if one?
    end
      
    def self.nombre_repositorio
      first.nombre_repositorio if one?
    end
      
    def self.destinatario_notificacion
      first.destinatario_notificacion if one?
    end
      
    def self.dias_para_vencer_documento
      first.dias_para_vencer_documento if one?
    end
      
  end 
end  
  
