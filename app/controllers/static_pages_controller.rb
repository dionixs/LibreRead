# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    # TODO: add dashboard(?)
    redirect_to controller: 'imports', action: 'new' if user_signed_in?
  end
end
