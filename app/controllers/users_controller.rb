class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    # Create a new user with nil values
  	@user = User.new
  end

  def show
    # Display the existing user data to the view
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end


  def edit
    # Edit view now has access to existing user
    @user = User.find(params[:id])
  end

  def create
    # New view supplies the controller with user input values
  	@user = User.new(user_params)
  	if @user.save
      # Send and email using the account_activation functions built in user_mailer, deliver_now ofcourse
      UserMailer.account_activation(@user).deliver_now
      # Output to the user to check email
  		flash[:info] = "Please check your email to activate your account"
      # Redirecto to rool url
  		redirect_to root_url
  	else
  		render 'new'
  	end
  end

  def update
    # Find the user by ID
    @user = User.find_by(params[:id])
    # if the user click update, using the new params entered by the user
    if @user.update_attributes(user_params)
      # Handle dat
      flash[:success] = "Profile updated"
      # redirecto to user page
      redirect_to @user
    else
      # if fails, stay on page
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User Deleted"
    redirect_to users_path
  end 

  private

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end
