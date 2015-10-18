class SessionsController < ApplicationController
  def new

  end

  def create
  	# finds the user by matching the email after downcasing the entire string
  	user = User.find_by(email: params[:session][:email].downcase)

  	# if the user exist and the pw params pass the authentication process provided by has_secure_password then.....
  	if user && user.authenticate(params[:session][:password])
  		if user.activated?
	  		# Log the user in and redirect to profile page/where ever desired
	  		log_in user
	  		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
	  		redirect_back_or user
	  	else
	  		message = "Account not activated. "
	  		message += "Check your email for the activation link."
	  		flash[:warning] = message
	  		redirect_to root_url
  		end
  	else
  		# Create and display error (Failed sign in!)
  		flash[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_path
  end
end
