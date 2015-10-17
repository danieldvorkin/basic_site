class SessionsController < ApplicationController
  def new

  end

  def create
  	# finds the user by matching the email after downcasing the entire string
  	user = User.find_by(email: params[:session][:email].downcase)

  	# if the user exist and the pw params pass the authentication process provided by has_secure_password then.....
  	if user && user.authenticate(params[:session][:password])
  		# Log the user in and redirect to profile page/where ever desired
  		log_in user
  		params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  		redirect_back_or user
  		flash[:success] = "Welcome Back!! " + user.name
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
