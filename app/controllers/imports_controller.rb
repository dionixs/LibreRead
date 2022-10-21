# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :require_authentication
  before_action :check_pass_changed
  before_action :set_import, only: %i[new create]
  before_action :find_import!, only: %i[show download destroy]
  before_action :authorize_import!
  after_action :verify_authorized
  before_action :set_text_file, only: %i[create]
  before_action :import_text_file, only: %i[create]

  def index
    @pagy, @imports = pagy Import.where(user_id: current_user.id).order(created_at: :desc)
    @imports = @imports.decorate
  end

  def show
    redirect_to import_notes_url(params[:id])
  end

  def upload; end

  def download
    send_data(@import.data, filename: @import.filename)
  end

  def new; end

  def create
    if @import.save
      import_notes(@import, @notes)
      redirect_to imports_path, notice: t('flash.notice.import_complete')
    else
      render 'new'
    end
  end

  def destroy
    filename = @import.filename
    @import.destroy
    redirect_to imports_path,
                notice: t('flash.notice.successfully_deleted.import',
                          name: t('global.names.file'),
                          filename: filename.to_s)
  end

  private

  def import_params
    params.require(:import).permit(:text_file)
  end

  def set_import
    @import = Import.new
  end

  def find_import!
    @import = Import.find(params[:id] || params[:import_id])
  end

  def set_text_file
    @file = import_params[:text_file]
  end

  def import_text_file
    # Add upload action (?)
    if text_file?(@file)
      @import = new_import(@file)
      @notes = extract_notes(@import.data)
      old_notes = saved_notes_for_current_user(current_user)
      @notes = unique_notes_for_import(@notes, old_notes)
    end
    render 'new' if import_failed?(@file, @notes)
  end

  def authorize_import!
    authorize(@import || Import)
  end
end
