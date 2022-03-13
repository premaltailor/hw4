class SessionsController < ApplicationController
  def new
  end

  def create
    # authenticate the user
    @user = User.where({ email: params["email"] })[0]
    if @user
      if BCrypt::Password.new(@user.password) == params["password"]
        session[:user_id] = @user.id
        flash[:notice] = "Welcome!"
        redirect_to "/places"
      else
        flash[:notice] = "Incorrect Password."
        redirect_to "/sessions/new"
      end
    else
      flash[:notice] = "Not signed in."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Logged Out."
    redirect_to "/sessions/new"
  end
end
  