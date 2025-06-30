class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]

  def index
    @user = Queries::UserFilters.new(User.all).call(search_params)
    render json: @recipes, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserProcessingService.new(user).send_initiation_email
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def search_params
    params(:search).permit(:name, :page_number, :per_page)
  end

  def user_params
    params(:user).permit(:name, :email, :avatar)
  end
end
