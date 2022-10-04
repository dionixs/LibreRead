# frozen_string_literal: true

class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :require_authentication, only: %i[index show edit update destroy]
  before_action :check_pass_changed
  before_action :find_import!, only: %i[index show edit update destroy]
  before_action :find_note!, only: %i[show edit update destroy]

  def index
    @pagy, @notes = pagy @import.notes.order(created_kindle_at: :asc)
    @notes = @notes.decorate
    session[:return_to] = request.fullpath
  end

  def show; end

  def edit; end

  def update
    if @note.update(notes_params)
      flash[:notice] = t('flash.notice.successfully_updated', name: t('activerecord.models.note'))
      redirect_to "#{session[:return_to]}##{dom_id(@note)}"
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = t('flash.notice.successfully_deleted.note', name: t('activerecord.models.note'))
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
    @note = @import.notes.find(params[:id]).decorate
  end
end
