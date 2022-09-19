# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      do_sign_in(user)
    else
      flash.now[:alert] = 'Incorrect email and/or password!'
      render :new
    end
  end

  def destroy
    flash[:notice] = 'See you later!'
    sign_out
    redirect_to root_path
  end

  private

  def do_sign_in(user)
    sign_in(user)
    remember(user) if params[:remember_me] == '1'
    redirect_to root_path, notice: "Welcome to the app, #{current_user.name_or_email}!"
  end
end
