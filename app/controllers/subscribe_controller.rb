class SubscribeController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  before_action :redirect_to_signup, only: [:new]

  def new 
  end 

  def update 
    # Get the credit card details submitted by the form 
    token = params[:stripeToken] 
    # Create a Customer 
    customer = Stripe::Customer.create( 
      :source => token, 
      :plan => "monthly", 
      :email => current_user.email
    ) 

    # Save stripe information to the current user using Devise helper
    current_user.stripe_subscription_id = true 
    current_user.stripe_id = customer.id 
    current_user.save 
    # Redirect back to products page with a ‘success’ notice 
    redirect_to root_path, notice: 'Thanks for signing up. Scrive away!'
  end

  private
    def redirect_to_signup
      if !user_signed_in?
        session["user_return_to"] = new_subscribe_path
        redirect_to new_user_registration_path
      end
    end
end
