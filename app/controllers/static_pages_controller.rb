class StaticPagesController < ApplicationController
  PER = 5

  def home
      @posts = Post.order('updated_at DESC').page(params[:page]).per(PER)
  end
end
