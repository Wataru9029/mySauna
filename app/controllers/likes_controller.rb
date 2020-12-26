class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.create(post_id: params[:post_id])
    redirect_to root_url
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
    redirect_to root_url
  end
end
