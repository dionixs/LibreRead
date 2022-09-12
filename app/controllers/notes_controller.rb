class NotesController < ApplicationController
  before_action :find_note!, only: %i[edit update destroy show]
  before_action :find_import!, only: %i[edit update destroy]

  def index
    @notes = Note.where(import_id: params[:import_id])
  end

  def show; end

  def edit; end

  def update
    @note = @import.notes.find(params[:id])
    if @note.update(notes_params)
      flash[:notice] = 'Successfully updated!'
      redirect_to import_notes_path
    else
      render :edit
    end
  end

  def destroy
    @note = @import.notes.find(params[:id])
    @note.destroy
    flash[:notice] = 'Successfully deleted.'
    redirect_to import_notes_path(params[:import_id])
  end

  private

  def notes_params
    params.require(:note).permit(:clipping)
  end

  def find_note!
    @note = Note.find_by(id: params[:id])
  end

  def find_import!
    @import = Import.find(params[:import_id])
  end
end
