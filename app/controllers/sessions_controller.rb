# frozen_string_literal: true

class SessionsController < ApplicationController
  after_action :set_route_info, except: %i[create destroy]
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy
  before_action :set_user, only: :create

  def new; end

  def create
    if @user&.authenticate(user_params[:password])
      do_sign_in(@user)
    else
      flash.now[:alert] = t('.create.flash.alert')
      render :new
    end
  end

  def destroy
    flash[:notice] = t('.destroy.flash.alert')
    sign_out
    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.permit(:email, :password)
  end

  def set_user
    @user = User.find_by email: user_params[:email]
  end

  def do_sign_in(user)
    sign_in(user)
    remember(user) if params[:remember_me] == '1'
    flash[:notice] = t('flash.notice.welcome', name: current_user.name_or_email)
    password_must_be_changed? ? check_pass_changed : redirect_to(root_path)
  end
end
