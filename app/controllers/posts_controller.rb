class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :search]

  def index
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}")
    else
      @posts = Post.all
    end
    @posts = @posts.order('updated_at DESC').page(params[:page]).per(PER)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_id: current_user.id)
    if @post.update_attributes(post_params)
      flash[:info] = "新規記事が投稿されました！"
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id && @post.update_attributes(post_params)
      flash[:info] = "記事が編集されました！"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id && @post.destroy
      flash[:danger] = "記事が削除されました！"
    end
    redirect_to root_url
  end

  def search
    @posts = Post.search(params[:title_or_description_cont])
    @posts = @posts.order('updated_at DESC').page(params[:page]).per(PER)
  end

  private

  # 記事投稿時に許可する属性
  def post_params
    params.require(:post).permit(:title, :image, :remove_image, :address, :description, :site_url, :tag_list)
  end
end
