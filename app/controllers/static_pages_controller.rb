# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def index
    redirect_to controller: 'dashboard', action: 'index' if user_signed_in?
  end
end
