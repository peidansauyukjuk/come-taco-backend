# frozen_string_literal: true

class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: %i[show get_items]
  # skip_before_action :authorized

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
  end

  def destroy
    @user = User.find(params[:id])

  end

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def get_items
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
