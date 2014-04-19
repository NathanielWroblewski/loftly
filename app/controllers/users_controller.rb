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
  end

  def update
    binding.pry
    begin
      customer = Stripe::Customer.create(
        email: params[:stripeEmail],
        card:  params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        customer:    customer.id,
        amount:      3000,
        description: 'Loftly Stripe customer',
        currency:    'usd'
      )

      user = User.find_by(slug: params[:id])
      user.update_attributes(
        stripe_token: params[:stripeToken],
        email:        params[:stripeEmail]
      )
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
