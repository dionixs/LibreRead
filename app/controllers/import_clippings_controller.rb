class ImportClippingsController < ApplicationController
  def new; end

  #todo
  def create
    @filename = params[:file]

    if @filename.blank?
      redirect_to :import_clippings, notice: 'You have not selected a file' and return
    elsif File.file?(@filename) && File.extname(@filename) == '.txt'
      @notes = Parser.new(@filename).notes
      # redirect_to :notes_path
    else
      redirect_to :import_clippings, notice: 'Must be a txt file' and return
    end

    render plain: @notes
  end
end
