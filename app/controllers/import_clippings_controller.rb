class ImportClippingsController < ApplicationController
  before_action :set_import, only: %i[new create]
  before_action :find_import, only: %i[show destroy]

  def index
    @imports = Document.all
  end

  def show
    send_data(
      @import.data,
      filename: @import.filename,
      disposition: 'download'
    )
  end

  def new; end

  # todo
  def create
    @text_file = params[:text_file]
    if !@text_file.nil? && File.extname(@text_file.to_io) == '.txt'
      @import = Document.new(
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
      render 'new' and return
    end

    if @import.save
      @notes.each { |note| Note.new(note).save }
      redirect_to imports_path, notice: 'Import Complete!'
    else
      render 'new'
    end
  end

  def destroy
    # TODO: добавить удаление заметок из бд
    @import.destroy
    redirect_to imports_path, notice: 'Successfully deleted.'
  end

  private

  def set_import
    @import = Document.new
  end

  def find_import
    @import = Document.find(params[:id])
  end
end
