module AlfrescoBcmUtils
  class ConfiguracionCorreo < ActiveRecord::Base
    self.table_name = 'configuracion_correo'

    def self.servidor_smtp
      first.servidor_smtp if one?
    end

    def self.puerto
      first.puerto if one?
    end

    def self.cuenta_correo
      first.cuenta_correo if one?
    end

    def self.password
      first.password if one?
    end

    def self.tipo_autenticacion
      first.tipo_autenticacion if one?
    end

    def self.tls?
      (first.tls.zero? ? false : true) if one?
    end
        
    
  end 
end  
  
