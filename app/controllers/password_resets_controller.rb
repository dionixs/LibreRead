# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  after_action :set_route_info, except: %i[create update]
  before_action :require_no_authentication

  def new; end

  def create
    @user = User.find_by email: params[:email]

    if @user.present?
      @user.set_password_reset_token

      PasswordResetMailer.with(user: @user).reset_email.deliver_later
    end

    flash[:success] = t '.success'
    redirect_to new_session_path
  end

  def edit; end

  def update; end
end
