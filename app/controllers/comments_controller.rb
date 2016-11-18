class CommentsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :find_comment_error

  load_and_authorize_resource :review
  load_and_authorize_resource

  def new
    comment = Comment.find_by id: params[:parent_id]
    if comment
      @supports = Supports::CommentSupport.new comment
    else
      respond_js
    end
  end

  def create
    @comment = if params[:comment][:parent_id].present?
      parent = Comment.find_by id: params[:comment].delete(:parent_id)
      parent.children.build comment_params
    else
      current_user.comments.build comment_params
    end

    if @comment.save
      load_comments
      respond_js
    else
      redirect_to tour_path @review.tour
      flash[:danger] = t "controller.comment_error"
    end
  end

  def edit
    respond_js
  end

  def update
    if @comment.update_attributes comment_params
      load_comments
      respond_js
    else
      redirect_to tour_path @review.tour
      flash[:danger] = t "controller.update_fail"
    end
  end

  def destroy
    if @comment.destroy
      @comments = @review.comments.hash_tree limit_depth: Settings.limitdepth
      respond_js
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content, :review_id, :user_id
  end

  def respond_js
    respond_to do |format|
      format.html{redirect_to tour_path @review.tour}
      format.js
    end
  end

  def load_comments
    @comments = @review.comments.hash_tree limit_depth: Settings.limitdepth
    @comment = current_user.comments.build
  end

  def find_comment_error
    flash[:danger] = t "controller.find_comment_fail"
    redirect_to tour_path @review.tour
  end
end
