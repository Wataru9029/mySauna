class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(:user_id => current_user.id, :room_id => params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(:user_id => current_user.id))
      flash[:notice] = 'メッセージが送信されました！'
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_to root_url
    end
  end

  def destroy
    @message = Message.find(params[:id])
    flash[:alert] = 'メッセージが削除されました！' if current_user.id == @message.user_id && @message.destroy
    redirect_to "/rooms/#{@message.room_id}"
  end
end
