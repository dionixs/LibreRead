# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  after_action :set_route_info, except: %i[create update]
  before_action :require_no_authentication

  def new; end

  def create
    PasswordResetMailer.with(user: @user).reset_email.deliver_later
  end

  def edit; end

  def update; end
end
