class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new
    if @post.update_attributes(post_params)
      flash[:info] = "新規記事が投稿されました！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

  # 記事投稿時に許可する属性
  def post_params
    params.require(:post).permit(:title, :image, :address, :description, :site_url)
  end
end
