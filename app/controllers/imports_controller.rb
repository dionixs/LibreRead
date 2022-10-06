# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :require_authentication, only: %i[index show new create destroy]
  before_action :check_pass_changed
  before_action :set_import, only: %i[new create]
  before_action :find_import!, only: %i[show destroy]
  before_action :import_text_file, only: %i[create]

  def index
    @pagy, @imports = pagy Import.order(created_at: :desc)
                                 .where(user_id: current_user.id)
    @imports = @imports.decorate
  end

  def show
    send_data(
      @import.data,
      filename: @import.filename
    )
  end

  def new; end

  def create
    # TODO: Refactoring
    if @import.save
      @notes = @notes&.each_with_object([]) do |note, array|
        note[:user_id] = current_user.id
        array << @import.notes.build(note)
      end
      Note.import @notes, recursive: true
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
    @import = Import.find(params[:id])
  end

  def import_text_file
    @file = import_params[:text_file]
    @notes = nil

    if text_file?(@file)
      @import = new_import_text_file(@file)
      @notes = extract_notes(@import.data)
    end

    render 'new' if import_failed?(@file, @notes)
  end
end
