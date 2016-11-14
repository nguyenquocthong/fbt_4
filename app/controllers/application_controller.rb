class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html{
        flash[:danger] = t "controller.permission"
        redirect_to root_path
      }
      format.js{render "shared/must_sign_in.js.erb"}
    end
  end

  rescue_from ActiveRecord::RecordNotFound do
    flash[:notice] = t "application.nil"
    redirect_to root_url
  end
end
