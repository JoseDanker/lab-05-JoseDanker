class ChatsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @chats = current_user.admin? ? Chat.all : Chat.involving(current_user.id)
  end

  def show
    @chat = Chat.find(params[:id])
    authorize! :read, @chat
    @messages = @chat.messages
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    authorize! :create, @chat  # ← ahora que tiene sender_id y receiver_id

    if @chat.save
      redirect_to @chat, notice: 'Chat was successfully created.'
    else
      render :new
    end
  end


  def edit
    @chat = Chat.find(params[:id])
  end

  def update
    @chat = Chat.find(params[:id])
    if @chat.update(chat_params)
      redirect_to @chat, notice: 'Chat was successfully updated.'
    else
      render :edit
    end
  end
  def destroy
    @chat = Chat.find(params[:id])
    if @chat.destroy
      redirect_to chats_path, notice: 'Chat was successfully deleted.'
    else
      redirect_to @chat, alert: 'Error deleting chat.'
    end
  end


  private

  def set_chat
    @chat = Chat.find(params[:id])
  end

  def chat_params
    params.require(:chat).permit(:sender_id, :receiver_id)
  end
end
