# frozen_string_literal: true

class SessionsController < ApplicationController
  # after_action :set_route_info, except: %i[create destroy]
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: :destroy

  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      do_sign_in(user)
    else
      flash.now[:alert] = t('.create.flash.alert')
      render :new
    end
  end

  def destroy
    flash[:notice] = t('.destroy.flash.alert')
    sign_out
    redirect_to root_path
  end

  private

  def do_sign_in(user)
    sign_in(user)
    remember(user) if params[:remember_me] == '1'
    flash[:notice] = t('flash.notice.welcome', name: current_user.name_or_email)
    password_must_be_changed? ? check_pass_changed : redirect_to(root_path)
  end
end
