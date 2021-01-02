class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('updated_at DESC').page(params[:page]).per(PER)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:info] = "プロフィールが更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.page(params[:page]).per(PER)
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(PER)
  end

  private

  # プロフィール編集時に許可する属性
  def user_params
    params.require(:user).permit(:name, :email, :image, :remove_image, :introduction)
  end

  # 権限のないページへのアクセス&編集を制限
  def correct_user
    user = User.find(params[:id])
    unless current_user && current_user == user
      flash[:danger] = "権限がありません！"
      redirect_to(root_url)
    end
  end
end
