class RoomsController < ApplicationController
  before_action :authenticate_user!

  def create
    @room = Room.create
    @entry1 = Entry.create(:room_id => @room.id, :user_id => current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(:room_id => @room.id))
    redirect_to "/rooms/#{@room.id}"
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(:user_id => current_user.id, :room_id => @room.id)
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
      @entries.each do |e|
        unless e.user.name == current_user.name
          @otherUser = e.user
        end
      end
    else
      redirect_to root_url
    end
  end
end
