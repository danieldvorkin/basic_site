class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    # Create a new user with nil values
  	@user = User.new
  end

  def show
    # Display the existing user data to the view
  	@user = User.find(params[:id])
  end

  def edit
    # Edit view now has access to existing user
    @user = User.find(params[:id])
  end

  def create
    # New view supplies the controller with user input values
  	@user = User.new(user_params)
  	if @user.save
      log_in @user
  		flash[:success] = "Welcome to the Sample App!" + @user.name
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def update
    @user = User.find_by(params[:id])
    if @user.update_attributes(user_params)
      # Handle dat
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "You must log in to proceed"
        redirect_to login_path
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
