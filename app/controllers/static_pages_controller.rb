# frozen_string_literal: true

class StaticPagesController < ApplicationController
  before_action :check_pass_changed

  def index
    # TODO: add dashboard(?)
    redirect_to controller: 'imports', action: 'new' if user_signed_in?
  end
end
