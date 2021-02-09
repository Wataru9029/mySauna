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
end
