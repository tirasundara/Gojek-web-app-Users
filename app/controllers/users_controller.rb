require 'rest-client'
require 'json'

class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update, :topup_gopay, :update_gopay]
  before_action :user_params, only: [:create, :update, :update_gopay]
  before_action :initialize_order_params, only: [:initialize_order]
  before_action :ensure_origin_destination_is_filled, only: [:initialize_order]

  # GET /users/new
  # or
  # GET /signup
  def new
    @user = User.new
  end

  def new_order
    @order_errors = {}
  end

  def initialize_order
    @order_errors = {}
    init_order_response = RestClient.get(BASE_ORDER_API_URL+initialize_order_params)
    if JSON.parse(init_order_response.body).size > 5
      @order = JSON.parse(init_order_response.body)
    else
      @order_errors = JSON.parse(init_order_response.body)
      render :new_order
    end
  end

  def confirm_order
    params_hash = {}
    params_hash[:origin] = params[:origin]
    params_hash[:destination] = params[:destination]
    params_hash[:distance] = params[:distance]
    params_hash[:payment_type] = params[:payment_type]
    params_hash[:price] = params[:price]
    params_hash[:user_id] = current_user.id
    params_hash[:service_type] = params[:service_type]
    response = RestClient.post(BASE_ORDER_API_URL, params_hash )
    if response.code == 201
      redirect_to current_order_path(current_user)
    else
      flash[:danger] = "Whoops, Something went wrong..."
      redirect_to new_order_path(current_user)
    end
  end

  def current_order
    response = RestClient.get(BASE_ORDER_API_URL + "/show?user_id=#{current_user.id}")
    @order = JSON.parse(response.body)
  end

  # GET /users/:id
  def show
  end

  def orders_history
    user_id = current_user.id
    orders_response = RestClient.get(BASE_ORDER_API_URL+"?user_id=#{user_id}")
    @orders = JSON.parse(orders_response.body)
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
      profile_attributes = { id: @user.id, name: @user.name, email: @user.email, phone: @user.phone }
      $kafka_producer.produce(profile_attributes.to_json, topic: "update-user-profile")
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render :edit
    end
  end

  # GET /users/:id/topup
  def topup_gopay
  end

  # PATCH /users/:id/topup
  def update_gopay
    old_gopay_balance = @user.gopay_balance
    @user.gopay_balance = user_params[:gopay_balance]
    if @user.valid?
      @user.gopay_balance += old_gopay_balance
      @user.save
      gopay_attributes = { id: @user.id, gopay_balance: @user.gopay_balance }
      $kafka_producer.produce(gopay_attributes.to_json, topic: "gopay-topup")
      flash[:success] = "Topup success."
      redirect_to @user
    else
      @user.gopay_balance = old_gopay_balance
      flash[:danger] = "Topup failed."
      render :topup_gopay
    end
  end

  private
  def ensure_origin_destination_is_filled
    if params[:origin].empty? || params[:destination].empty?
      flash.now[:danger] = "Please fill the origin and destination fields."
      render :new_order
    end
  end

  def initialize_order_params
    init_order_params = "/new?"
    init_order_params += "origin=#{params[:origin]}&"
    init_order_params += "destination=#{params[:destination]}&"
    init_order_params += "service_type=#{params[:service_type]}&"
    init_order_params += "payment_type=#{params[:payment_type]}&"
    init_order_params += "user_id=#{params[:user_id]}"
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :phone, :gopay_balance)
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
