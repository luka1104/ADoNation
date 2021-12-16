class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller? 

  def remote_ip
    if request.remote_ip == '::1'
      '123.45.67.89'
    else
      request.remote_ip
    end
  end

  private

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile, :url, :area, %i(avatar)])
    end
end
