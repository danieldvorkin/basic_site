class SessionController < ApplicationController
  def new

  end

  def create
  	# finds the user by matching the email after downcasing the entire string
  	user = User.find_by(email: params[:session][:email].downcase)

  	# if the user exist and the pw params pass the authentication process provided by has_secure_password then.....
  	if user && user.authenticate?(params[:session][:password])
  		# Log the user in and redirect to profile page/where ever desired
  	else
  		# Create and display error (Failed sign in!)
  		render 'new'
  	end
  end

  def destroy

  end
end
