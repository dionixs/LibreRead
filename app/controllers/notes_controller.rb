# frozen_string_literal: true

class NotesController < ApplicationController
  include ActionView::RecordIdentifier

  after_action :set_route_info, except: %i[show]
  before_action :require_authentication, only: %i[index show edit update destroy]
  before_action :check_pass_changed
  before_action :find_import!, only: %i[index show edit update destroy]
  before_action :find_note!, only: %i[show edit update destroy]
  before_action :find_notes!, only: %i[index]
  before_action -> { owner?(@note) }, only: %i[show edit update destroy]

  def index
    @pagy, @notes = pagy @notes.order(created_kindle_at: :asc)
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

  def find_import!
    @import = Import.find(params[:import_id])
  end

  def find_note!
    @note = @import.notes.find(params[:id]).decorate
  end

  def find_notes!
    return @notes = @import.notes.where(user_id: current_user.id) unless params[:tags]

    @notes = Note.tagged_with(tags: params[:tags], import_id: params[:import_id])
  end

  def return_to
    flash[:notice] = t('flash.notice.successfully_updated', name: t('activerecord.models.note'))
    "#{session[:return_to]}##{dom_id(@note)}"
  end
end
