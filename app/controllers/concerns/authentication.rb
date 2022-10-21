# frozen_string_literal: true

module Authentication
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    private

    def current_user
      user = session[:user_id].present? ? user_from_session : user_from_token

      @current_user ||= user&.decorate
    end

    def user_from_session
      User.find_by(id: session[:user_id])
    end

    def user_from_token
      user = User.find_by(id: cookies.encrypted[:user_id])
      token = cookies.encrypted[:remember_token]

      return unless user&.remember_token_authenticated?(token)

      sign_in user
      user
    end

    def user_signed_in?
      current_user.present?
    end

    def require_no_authentication
      return unless user_signed_in?

      flash[:alert] = t('flash.alert.user_signed_in')
      redirect_to root_path
    end

    def require_authentication
      return if user_signed_in?

      flash[:alert] = t('flash.alert.user_not_signed_in')
      redirect_to new_session_path
    end

    def check_pass_changed
      return unless password_must_be_changed?

      flash[:alert] = t('flash.alert.password_must_be_changed')
      redirect_to edit_user_path(current_user)
    end

    def password_must_be_changed?
      current_user&.password_must_be_changed
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def remember(user)
      user.remember_me
      cookies.encrypted[:remember_token] = {
        value: user.remember_token, expires: 1.month
      }
      cookies.encrypted[:user_id] = { value: user.id, expires: 1.month }
    end

    def forget(user)
      user.forget_me
      cookies.delete :user_id
      cookies.delete :remember_token
    end

    def sign_out
      forget current_user
      session.delete :user_id
      @current_user = nil
    end

    helper_method :current_user, :user_signed_in?
  end
  # rubocop:enable Metrics/BlockLength
end
