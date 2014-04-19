class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { user: user.attributes }
    else
      render status: :internal_server_error
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :bedrooms, :min_price, :max_price, :intro
    )
  end
end
