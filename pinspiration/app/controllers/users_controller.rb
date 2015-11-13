class UsersController < ApplicationController

  skip_before_action :authenticate
  
  def index
    @users = User.all
  end

  def sign_up

  end

  def sign_up!
    user = User.new(
      name: params[:name],
      email: params[:email],
      username: params[:username],
      password_digest: BCrypt::Password.create(params[:password])

    )
    if params[:password_confirmation] != params[:password]
      message = "Your passwords don't match!"
    elsif user.save
      message = "Your account has been created!"
    else
      message = "Your account couldn't be created. Did you enter a unique username and password?"
    end
    puts message
    flash[:notice] = message
    redirect_to action: :sign_up
  end

  def sign_in
  end

  def sign_in!
    @user = User.find_by(username: params[:username])
    if !@user
      message = "This user doesn't exist!"
    elsif !BCrypt::Password.new(@user.password_digest).is_password?(params[:password])
      message = "Your password's wrong!"
    else
      message = "You're signed in, #{@user.username}!"
      cookies[:username] = @user.username
      session[:user] = @user
    end
    puts message
    flash[:notice] = message
    redirect_to action: :sign_in
  end

  def sign_out
    message = "You're signed out!"
    flash[:notice] = message
    reset_session
    redirect_to root_url
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])

  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render "new"

    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end

end
