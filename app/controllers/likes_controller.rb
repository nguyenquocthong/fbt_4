class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_likeable, only: [:create, :destroy]
  before_action :find_like, only: :destroy

  def create
    @like = @likeable.likes.build user: current_user
    if @like.save
      respond_to do |format|
        format.html {redirect_to tour_path @tour_id}
        format.js
      end
    else
      redirect_to tour_path @tour_id
      flash[:danger] = t "view.like_fail"
    end
  end

  def destroy
    authorize! :destroy, @like
    if @like.destroy
      respond_to do |format|
        format.html {redirect_to tour_path @tour_id}
        format.js
      end
    else
      redirect_to tour_path @tour_id
      flash[:danger] = t "view.unlike_fail"
    end
  end

  private
  def check_likeable
    model = [Review, Comment].detect{|c| params["#{c.name.underscore}_id"]}
    @likeable = model.find params["#{model.name.underscore}_id"]
    @tour_id = if model == Review
      @likeable.tour.id
    else
      @likeable.review.tour.id
    end
    if @likeable.nil?
      flash[:danger] = t "controller.error"
      redirect_to root_path
    end
  end

  def find_like
    @like = @likeable.likes.find_by user: current_user
    if @like.nil?
      redirect_to tour_path @tour_id
      flash[:danger] = t "view.find_like_fail"
    end
  end
end
