class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if fllowing.save
      flash[:info] = "ユーザーをフォローしました"
    else
      flash[:danger] = "ユーザーのフォローに失敗しました"
    end
    redirect_to @user
  end

  def destroy
    following = current_user.unfollow(@user)
    if fllowing.destroy
      flash[:info] = "ユーザーのフォロー解除しました"
    else
      flash[:danger] = "ユーザーのフォロー解除に失敗しました"
    end
    redirect_to @user
  end

  private

  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end
end
