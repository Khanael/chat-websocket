class MessagesController < ApplicationController
  def create
    @message = Message.new(params_message)
    @message.user = current_user
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message.chatroom = @chatroom
    if @message.save!
      ChatroomChannel.broadcast_to(
        @chatroom,
        json: {
          message: @message,
          user: @message.user
        }
      )
      head :ok
    else
      render "chatrooms/show", status: :unprocessable_entity
    end

  end

  private

  def params_message
    params.require(:message).permit(:content)
  end
end
