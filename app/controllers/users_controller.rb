class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
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

  private

  # プロフィール編集時に許可する属性
  def user_params
    params.require(:user).permit(:name, :email, :image, :remove_image, :introduction)
  end
end
