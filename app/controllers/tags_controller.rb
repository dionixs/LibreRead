# frozen_string_literal: true

# TODO: Refactoring
class TagsController < ApplicationController
  include ActionView::RecordIdentifier

  after_action :set_route_info, except: %i[create]
  before_action :require_authentication
  before_action :find_note!, only: %i[create]
  before_action -> { owner?(@note) }
  # before_action :set_tags, only: %i[create]

  def create
    render plain: 'Функция находиться в разработке'
    # (@note.tag_list = (tags_params))
    # flash[:notice] = t('tags.flash.notice.successfully_created')
    # redirect_to session[:return_to]
  end

  def destroy; end

  private

  def tags_params
    params.require(:tag).permit(:tags, :note_id).merge(user_id: current_user.id)
  end

  def find_note!
    @note = Note.find(tags_params[:note_id])
  end
end
