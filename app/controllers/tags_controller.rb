# frozen_string_literal: true

class TagsController < ApplicationController
  after_action :set_route_info, except: %i[create]
  before_action :require_authentication
  # before_action :find_note!, only: %i[:create]
  # before_action -> { owner?(@note) }
  # before_action :set_tag, only: %i[:create]

  # TODO
  def create
    redirect_to root_path
    # respond_to do |format|
    #   format.js
    # end
  end

  def destroy
  end

  private

  def tags_params
    # params.require(:tag).permit(:title, :tag_list)
  end
end
