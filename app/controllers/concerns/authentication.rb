# frozen_string_literal: true
module Authentication
  extend ActiveSupport::Concern

  included do
    private

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
      @current_user&.decorate
    end

    def user_signed_in?
      current_user.present?
    end

    helper_method :current_user, :user_signed_in?
  end
end