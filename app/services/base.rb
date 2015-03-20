module Services
  class Base
    include ActiveModel::Model
    include ActiveModel::Validations
    
    def call
      raise NotImplementedError.new
    end
    
    def is_valid?
      raise NotImplementedError.new
    end
  end
end