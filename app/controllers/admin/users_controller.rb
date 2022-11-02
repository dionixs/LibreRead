# frozen_string_literal: true

module Admin
  class UsersController < BaseController
    after_action :set_route_info, except: %i[update destroy]
    before_action :require_authentication
    before_action :set_user!, only: %i[show edit update destroy]
    before_action :authorize_user!
    after_action :verify_authorized

    def index
      respond_to do |format|
        format.html do
          @pagy, @users = pagy User.order(created_at: :desc)
        end

        format.zip do
          UserBulkExportJob.perform_later current_user
          flash[:notice] = t '.success'
          redirect_to admin_users_path
        end
      end
    end

    # TODO: Add view
    def show; end

    def new
      @user = User.new
    end

    def edit; end

    def update
      if @user.update(admin_user_params)
        flash[:notice] = t('.update.flash.notice')
        redirect_to admin_users_path
      else
        render :edit
      end
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

    def destroy
      @user.destroy
      flash[:notice] = t('.destroy.flash.notice')
      redirect_to admin_users_path, status: :see_other
    end

    private

    def call_user_bulk_service
      return if not_zip_file(params[:archive])

      UserBulkImportJob.perform_later create_blob, current_user
      flash[:notice] = t('admin.users.create.notice.import_users')
    end

    def create_blob
      file = File.open params[:archive]
      result = ActiveStorage::Blob.create_and_upload! io: file,
                                                      filename: params[:archive].original_filename
      file.close
      result.key
    end

    def admin_user_params
      params.require(:user).permit(
        :email, :name, :role, :status,
        :admin_password, :password, :password_confirmation
      ).merge(admin_edit: true, admin_id: current_user.id)
    end

    def set_user!
      @user = User.find(params[:id])
    end

    def authorize_user!
      authorize(@user || User)
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
