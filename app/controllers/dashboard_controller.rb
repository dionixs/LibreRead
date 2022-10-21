# frozen_string_literal: true

class DashboardController < ApplicationController
  before_action :require_authentication, only: %i[index]
  before_action :check_pass_changed

  def index; end
end
