class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @post = Post.find(params[:id])
    if @comment.save
        flash[:info] = "新規コメントが投稿されました！"
    else
        flash[:danger] = "コメント投稿に失敗しました！"
    end
    redirect_to @post
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end
end
