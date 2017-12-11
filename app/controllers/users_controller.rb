class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :destroy]

  # GET /users
  def new
  end

  # GET /users/:id
  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
