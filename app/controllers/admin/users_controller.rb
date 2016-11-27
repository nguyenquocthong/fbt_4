class Admin::UsersController < ApplicationController
  load_and_authorize_resource

  def index
    @users = User.all.order(created_at: :desc).page params[:page]
  end
  
  def destroy
    if @user.destroy
      flash[:success] = t "controller.destroy_success"
    else
      flash[:success] = t "controller.destroy_fail"
    end
  end
end
