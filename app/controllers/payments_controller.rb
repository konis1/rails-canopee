class PaymentsController < ApplicationController
  def create
    # Create a customer in Stripe (not a User)
    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    # Now you have a customer object that you can use for future payments
    # You may want to save the customer.id to associate it with your application's user

    # Handle successful payment
    # ...

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_payment_path
  end
end
