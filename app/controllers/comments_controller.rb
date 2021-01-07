class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = current_user.comments.new(comment_params)
    if @comment.save
        flash[:info] = "新規コメントが投稿されました！"
    else
        flash[:danger] = "コメント投稿に失敗しました！"
    end
    redirect_to root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = Post.find(params[:id])
    if @comment.user_id == current_user.id && @comment.destroy
        flash[:info] = "コメントが削除されました！"
    else
        flash[:danger] = "コメント削除に失敗しました！"
    end
    redirect_to root_url
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
