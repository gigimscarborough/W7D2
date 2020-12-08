class UsersController < ApplicationController

  before_action :ensure_logged_in, only: [:destroy, :show]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

      if @user.save
        redirect_to user_url(@user)
      else
        flash[:errors] = @user.errors.full_messages
        render :new
      end

  end

  def show
    @user = User.find(params[:id])

    render :show
  end

  def destroy
    @user = User.find(params[:id])

    @user.destroy
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
