class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in(user)
      redirect_to root_path, notice: "Welcome to the app, #{current_user.name_or_email}!"
    else
      flash[:alert] = 'Incorrect email and/or password!'
      redirect_to new_session_path
    end
  end

  def destroy; end
end
