class ImportClippingsController < ApplicationController
  def index
    @imports = Document.all
  end

  def show
    @import  = Document.find(params[:id])
    send_data @import.data, filename: @import.filename, disposition: 'download'
  end

  def new
    @import = Document.new
  end

  # todo
  def create
    @import = Document.new
    @text_file = params[:text_file]

    if !@text_file.nil? && File.extname(@text_file.to_io) == '.txt'
      @import.filename = @text_file.original_filename
      @import.mime_type = @text_file.content_type
      @import.data = File.read(@text_file.to_io)
      @notes = ClippingsParser.new(@import.data).notes
    elsif @text_file.nil?
      flash[:notice] = 'You have not selected a file'
    else
      flash[:notice] = 'Must be a txt file'
    end

    if @notes.nil?
      flash[:notice] =  "Not a Kindle clipping file!"
      # todo
      render "new" and return
    end

    if @import.save
      # todo
      @notes.each { | note | Note.new(note).save }
      redirect_to imports_path
    else
      render "new"
    end
  end

  def destroy
    @import = Document.find(params[:id])
    @import.destroy
    redirect_to imports_path, notice:  "Successfully deleted."
  end
end
