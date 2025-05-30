class MessagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user.admin?
      @messages = Message.all
    else
      chat_ids = Chat.where("sender_id = :id OR receiver_id = :id", id: current_user.id).pluck(:id)
      @messages = Message.where(chat_id: chat_ids)
    end
  end

  

  def show
    @message = Message.find(params[:id])
    authorize! :read, @message
  end

  def new
    @message = Message.new
  end
  
  def create
    @message = Message.new(message_params)
    @message.user = current_user  

    authorize! :create, @message

    if @message.save
      redirect_to @message.chat, notice: "Message was successfully sent."
    else
      render :new
    end
  end


  def edit
    @message = Message.find(params[:id])
  end
  def update
    @message = Message.find(params[:id])
    if @message.update(message_params)
      redirect_to @message, notice: "Message was successfully updated."
    else
      render :edit
    end
  end
  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      redirect_to messages_path, notice: "Message was successfully deleted."
    else
      redirect_to @message, alert: "Error deleting message."
    end
  end

  

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:chat_id, :body)
  end

end
