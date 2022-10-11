# frozen_string_literal: true

class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :require_authentication, only: %i[index show edit update destroy]
  before_action :check_pass_changed
  before_action :find_import!, only: %i[index show edit update destroy]
  before_action :find_note!, only: %i[show edit update destroy]
  before_action :set_tag, only: %i[index show]
  before_action -> { owner?(@note) }, only: %i[show edit update destroy]

  def index
    @pagy, @notes = pagy @import.notes.order(created_kindle_at: :asc)
                                .where(user_id: current_user.id)
    # @tags = @notes.extract_associated(:note_tags)
    @notes = @notes.decorate
    # TODO
    session[:return_to] = request.fullpath
  end

  def show
    # @tags = @note.tag_list(user_id: current_user.id)
  end

  def edit; end

  def update
    if @note.update(notes_params)
      flash[:notice] = t('flash.notice.successfully_updated', name: t('activerecord.models.note'))
      # TODO: Add method
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

  # Refactoring
  def find_import!
    @import = Import.find(params[:import_id])
  end

  def set_tag
    @tag = Tag.new
  end
end
