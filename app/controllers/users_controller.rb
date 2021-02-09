class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order('updated_at DESC').page(params[:page]).per(PER)
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = 'プロフィールが更新されました！'
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
      flash[:alert] = '権限がありません！'
      redirect_to(root_url)
    end
  end
end
