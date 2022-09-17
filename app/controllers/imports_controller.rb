# frozen_string_literal: true

class ImportsController < ApplicationController
  before_action :set_import, only: %i[new create]
  before_action :find_import!, only: %i[show destroy]
  before_action :import!, only: %i[create]

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
      @notes.each { |note| @import.notes.build(note).save }
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

  # todo
  def import!
    @text_file = params[:import][:text_file]
    if !@text_file.nil? && File.extname(@text_file.to_io) == '.txt'
      @import = Import.new(
        filename: @text_file.original_filename,
        mime_type: @text_file.content_type,
        data: File.read(@text_file.to_io)
      )
      @notes = ClippingsParser.new(@import.data).notes
    elsif @text_file.nil?
      flash[:alert] = 'You have not selected a file'
    else
      flash[:alert] = 'Must be a txt file'
    end

    if @notes.nil?
      flash[:alert] = 'Not a Kindle clipping file!'
      render 'new'
    end
  end
end
