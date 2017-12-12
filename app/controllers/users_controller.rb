class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :user_params, only: [:create, :update]

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

  # GET /users/:id/edit
  def edit
  end

  # PATCH /users/:id
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to root_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_path unless current_user?(@user)
  end
end
