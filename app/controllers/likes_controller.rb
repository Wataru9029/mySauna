class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = Like.create(post_id: params[:post_id], user_id: current_user.id)
    post = Post.find(params[:post_id])
    post.create_notification_like!(current_user)
    respond_to :js
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
