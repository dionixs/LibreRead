# frozen_string_literal: true

class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :find_import!, only: %i[index show edit update destroy]
  before_action :find_note!, only: %i[show edit update destroy]

  def index
    @notes = @import.notes.order(created_kindle_at: :asc)
                    .page params[:page]
  end

  def show; end

  def edit; end

  def update
    if @note.update(notes_params)
      flash[:notice] = 'Successfully updated!'
      # todo
      redirect_to import_notes_path(anchor: dom_id(@note))
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = 'Successfully deleted.'
    redirect_to import_notes_path(params[:import_id])
  end

  private

  def notes_params
    params.require(:note).permit(:clipping)
  end

  def find_import!
    @import = Import.find(params[:import_id])
  end

  def find_note!
    @note = @import.notes.find(params[:id])
  end
end
