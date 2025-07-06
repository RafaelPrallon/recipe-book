class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    @users = User.with_attached_avatar.all
    @users = UserFilters.new(@users, search_params).call if params[:search]
    users_array = UserSerializer.new(@users).serializable_hash[:data].map { |d| d[:attributes] }
    render json: users_array, users_array: :ok
  end

  def show
    render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    render json: "User successfuly removed", status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def search_params
    params.require(:search).permit(:name, :page_number, :per_page)
  end

  def user_params
    params.permit(:name, :email, :avatar)
  end
end
