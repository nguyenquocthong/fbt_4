class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url
    flash[:danger] = t "controller.permission"
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = t "application.nil"
    redirect_to root_url
   end
end
