class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from ActionController::ParameterMissing do
    render :nothing => true, :status => 422
  end
    
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end
 
  private
 
  def record_not_found
   render plain: "404 Not Found", status: 404
  end
end
