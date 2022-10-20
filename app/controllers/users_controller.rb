# frozen_string_literal: true

class UsersController < ApplicationController
  after_action :set_route_info, except: %i[create update destroy]
  before_action :require_no_authentication, only: %i[new create]
  before_action :require_authentication, only: %i[edit update]
  before_action :set_user!, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: t('flash.notice.welcome', name: current_user.name_or_email.to_s)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:notice] = t('.update.flash.notice')
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = t('.destroy.flash.notice')
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :old_password,
                                 :password, :password_confirmation)
  end

  def set_user!
    @user = User.find(params[:id])
  end
end
