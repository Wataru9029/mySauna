class StaticPagesController < ApplicationController
  def home
      @post = Post.all
  end
end
