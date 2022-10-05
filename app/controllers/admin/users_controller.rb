# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
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

    def create
      if params[:archive].present?
        call_user_bulk_service
        redirect_to admin_users_path
      elsif params[:user].present?
        create_one_user
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

    def call_user_bulk_service
      return if not_zip_file(params[:archive])

      if UserBulkService.call params[:archive]
        flash[:notice] = t('admin.users.create.notice.import_users')
      else
        flash[:alert] = t('admin.users.create.alert.import_error')
      end
    end

    def admin_user_params
      params.require(:user).permit(:email, :name, :old_password,
                                   :password, :password_confirmation)
    end

    def create_one_user
      @user = User.new(admin_user_params)
      @user.password_must_be_changed = true
      if @user.save
        redirect_to admin_users_path, notice: t('admin.users.create.notice.create_user')
      else
        render :new
      end
    end

    def file_not_selected
      flash.now[:alert] = t('admin.users.create.alert.file_not_selected')
      render :upload
    end
  end
end
