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

  def edit
    @user = User.find_by(slug: params[:id])
    @plan = ENV['STRIPE_PLAN_ID']
  end

  def update
    begin
      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        card:  params[:stripeToken],
        plan:  'loftly_monthly'
      )

      user = User.find_by(slug: params[:id])
      user.update_attributes(
        stripe_token: params[:stripeToken]
      )
      user.activate
      redirect_to user, notice: 'Success.'
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to edit_user_path
    end
  end

  def show

  end

  def destroy

  end

  private

  def user_params
    params.require(:user).permit(
      :email, :bedrooms, :min_price, :max_price, :intro
    )
  end
end
