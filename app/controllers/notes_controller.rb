# frozen_string_literal: true

class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :require_authentication, only: %i[index show edit update destroy]
  before_action :check_pass_changed
  before_action :find_import!, only: %i[index show edit update destroy]
  before_action :find_note!, only: %i[show edit update destroy]
  before_action -> { owner?(@note) }, only: %i[show edit update destroy]

  def index
    @pagy, @notes = pagy @import.notes.order(created_kindle_at: :asc)
                                .where(user_id: current_user.id)
    # @tags = @notes.extract_associated(:note_tags)
    @notes = @notes.decorate
    session[:return_to] = request.fullpath
  end

  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @note.tags.to_json(only: ['title']) }
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @note.update(notes_params)
        format.html { redirect_to return_to }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @note.destroy
    flash[:notice] = t('flash.notice.successfully_deleted.note', name: t('activerecord.models.note'))
    redirect_to import_notes_path(params[:import_id])
  end

  private

  def notes_params
    params.require(:note).permit(:clipping, :all_tags)
  end

  # Refactoring
  def find_import!
    @import = Import.find(params[:import_id])
  end

  def return_to
    flash[:notice] = t('flash.notice.successfully_updated', name: t('activerecord.models.note'))
    "#{session[:return_to]}##{dom_id(@note)}"
  end
end
