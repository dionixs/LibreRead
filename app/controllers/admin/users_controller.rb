# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :require_authentication

  def index
    respond_to do |format|
      format.html do
        @pagy, @users = pagy User.order(created_at: :desc)
      end

      format.zip { respond_with_zipped_users }
    end
  end

  def new
    @user = User.new
  end

  def upload; end

  # todo
  def create
    if params[:archive].present?
      UserBulkService.call params[:archive]
      flash[:notice] = 'Users impoted!'
      redirect_to admin_users_path
    elsif params[:user].present?
      create_user
    else
      file_not_selected
    end
  end

  private

  def respond_with_zipped_users
    compressed_filestream = Zip::OutputStream.write_buffer do |zos|
      User.order(created_at: :desc).each do |user|
        zos.put_next_entry "user_#{user.id}.xlsx"
        zos.print render_to_string(
          layout: false, handlers: [:axlsx], formats: [:xlsx],
          template: 'admin/users/user',
          locals: { user: }
        )
      end
    end

    compressed_filestream.rewind
    send_data compressed_filestream.read, filename: 'users.zip'
  end

  def admin_user_params
    params.require(:user).permit(:email, :name, :old_password,
                                 :password, :password_confirmation)
  end

  # todo
  def create_user
    @user = User.new(admin_user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'User created!'
    else
      render :new
    end
  end

  # todo
  def file_not_selected
    flash.now[:warning] = 'File not selected!'
    render :upload
  end
end
