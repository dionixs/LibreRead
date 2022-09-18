# frozen_string_literal: true
class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

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

  def destroy
    flash[:notice] = 'See you later!'
    sign_out
    redirect_to root_path
  end
end
