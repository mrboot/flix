class UsersController < ApplicationController

  # require_signin is in ApplicationController
  before_action :require_signin, except: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Account details updated"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      # make sure we sign out the user by setting session to nil at teh same time.
      session[:user_id] = nil
      redirect_to root_path, notice: "Account deleted, sorry to see you go"
    else
      render :show
    end
  end

private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

end
