class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      UserProcessingService.new(user).send_initiation_email
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params(:user).permit(:name, :email, :avatar)
  end
end
