class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = Like.create(post_id: params[:post_id], user_id: current_user.id)
  end

  def destroy
    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    @like.destroy
  end
end
