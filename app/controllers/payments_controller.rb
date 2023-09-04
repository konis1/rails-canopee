# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  def create
    @user = Stripe::User.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    @charge = Stripe::Charge.create(
      user: user.id,
      amount: 10, # Amount in cents
      description: 'Example Charge',
      currency: 'usd'
    )

    # Handle successful payment
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
