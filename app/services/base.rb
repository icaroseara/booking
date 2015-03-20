module Services
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations
    
    def call
    end
    
    def is_valid?
    end
  end
end