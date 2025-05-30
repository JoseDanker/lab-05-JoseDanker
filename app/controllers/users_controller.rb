class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    authorize! :read, @user
    if @user.nil?
      redirect_to root_path, alert: "Usuario no encontrado."
    else
      @chats = @user.all_chats
      @messages = @user.messages
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end


  private 

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
