class SessionsController < ApplicationController

  def new
  end

  def create
    if user = User.authenticate(params[:email_or_username], params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back #{user.name}!"
      redirect_to user
    else
      # use flash.now to display flash message without witing for a new request
      flash.now[:alert] = "invalid username or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    # flash[:notice] = "logged out!"
    redirect_to root_path, notice: "Logged out!"
  end

end
