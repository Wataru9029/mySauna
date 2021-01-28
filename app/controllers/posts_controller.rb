class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search, :rank, :rate, :infection_control]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    if params[:tag_name]
      @posts = Post.tagged_with(params[:tag_name].to_s)
    else
      @posts = Post.all
    end
    @posts = @posts.order('updated_at DESC').page(params[:page]).per(PER)
    @like = Like.new
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(user_id: current_user.id)
    if @post.update(post_params)
      flash[:notice] = "新規記事が投稿されました！"
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
    if @post.user_id == current_user.id && @post.update(post_params)
      flash[:notice] = "記事が編集されました！"
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    flash[:alert] = "記事が削除されました！" if @post.user_id == current_user.id && @post.destroy
    redirect_to root_url
  end

  def search
    @posts = Post.search(params[:title_or_description_cont])
    @posts = @posts.order('updated_at DESC').page(params[:page]).per(PER)
  end

  def favorites
    @posts = current_user.liked_posts
    @posts = @posts.order('updated_at DESC').page(params[:page]).per(PER)
    @like = Like.new
  end

  def rank
    posts = Post.includes(:liked_users).sort { |a, b| b.liked_users.size <=> a.liked_users.size }
    @posts = Kaminari.paginate_array(posts).page(params[:page]).limit(10)
  end

  def rate
    @posts = Post.all.order('rate DESC').page(params[:page]).per(PER)
  end

  def infection_control
    @posts = Post.all.order('infection_control_rate DESC').page(params[:page]).per(PER)
  end

  def timeline
    @posts = current_user.feed.order('updated_at DESC').page(params[:page]).per(PER)
  end

  private

  # 記事投稿時に許可する属性
  def post_params
    params.require(:post).permit(:title, :image, :remove_image, :address, :description, :site_url, :tag_list, :rate, :infection_control_rate)
  end

  # 権限のないページへのアクセス&編集を制限
  def correct_user
    user = Post.find(params[:id]).user
    unless current_user && current_user == user
      flash[:danger] = "権限がありません！"
      redirect_to(root_url)
    end
  end
end
