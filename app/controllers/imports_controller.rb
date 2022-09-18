# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :set_import, only: %i[new create]
  before_action :find_import!, only: %i[show destroy]
  before_action :import_text_file, only: %i[create]

  def index
    @imports = Import.all.decorate
  end

  def show
    send_data(
      @import.data,
      filename: @import.filename,
      disposition: 'download'
    )
  end

  def new; end

  def create
    if @import.save
      @notes&.each { |note| @import.notes.build(note).save }
      redirect_to imports_path, notice: 'Import Complete!'
    else
      render 'new'
    end
  end

  def destroy
    @import.destroy
    redirect_to imports_path, notice: 'Successfully deleted.'
  end

  private

  def set_import
    @import = Import.new
  end

  def find_import!
    @import = Import.find(params[:id])
  end

  def import_text_file
    @file = params[:import][:text_file]
    @notes = nil

    if text_file?(@file)
      @import = new_import_text_file(@file)
      @notes = import_notes(@import)
    end

    render 'new' if import_failed?(@file, @notes)
  end
end
