class ImportClippingsController < ApplicationController
  def index
    @imports = Document.all
  end

  def new
    @import = Document.new
  end

  def create
    @import = Document.new
    @text_file = params[:text_file]

    if !@text_file.nil? && File.extname(@text_file.to_io) == '.txt'
      @import.filename = @text_file.original_filename
      @import.mime_type = @text_file.content_type
      @import.data = File.read(@text_file.to_io)
    elsif @text_file.nil?
      flash[:notice] = 'You have not selected a file'
    else
      flash[:notice] = 'Must be a txt file'
    end

    if @import.save
      @notes = Parser.new(@import.data).notes
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

  def show
    @import  = Document.find(params[:id])
    send_data @import.data, filename: @import.filename, disposition: 'download'
  end
end
