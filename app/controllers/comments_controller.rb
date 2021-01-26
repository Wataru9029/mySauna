class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(user_id: current_user.id, content: params[:comment][:content])
    if !@post.nil? && @comment.save
        flash[:notice] = "新規コメントが投稿されました！"
    else
        flash[:alert] = "コメント投稿に失敗しました！"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @comment.user_id == current_user.id && @comment.destroy
        flash[:notice] = "コメントが削除されました！"
    else
        flash[:alert] = "コメント削除に失敗しました！"
    end
    redirect_to post_url(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end
