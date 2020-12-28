class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    following = current_user.follow(@user)
  end

  def destroy
    following = current_user.unfollow(@user)
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
