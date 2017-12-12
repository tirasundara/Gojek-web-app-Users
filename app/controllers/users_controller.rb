class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]
  before_action :user_params, only: [:create, :edit]

  # GET /users/new
  # or
  # GET /signup
  def new
    @user = User.new
  end

  # GET /users/:id
  def show
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Go-JEK Web App!"
      redirect_to @user
    else
      render :new
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
