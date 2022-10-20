# frozen_string_literal: true

module Password
  extend ActiveSupport::Concern

  # rubocop:disable Metrics/BlockLength
  included do
    attr_accessor :old_password

    private

    def check_password_changed
      self.password_must_be_changed = false if password_must_be_changed == true
    end

    def digest(string)
      cost = if ActiveModel::SecurePassword
                .min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create(string, cost:)
    end

    def correct_admin_password
      admin = User.find(admin_id)
      return if correct_password?(admin.password_digest_was, admin_password)

      errors.add :admin_password, I18n.t('activerecord.errors.messages.is_incorrect')
    end

    def correct_old_password
      return if correct_password?(password_digest_was, old_password)

      errors.add :old_password, I18n.t('activerecord.errors.messages.is_incorrect')
    end

    def correct_password?(password_digest_was, password)
      BCrypt::Password.new(password_digest_was).is_password?(password)
    end

    def password_presence
      errors.add(:password, :blank) if password_blank?
    end

    def password_blank?
      password_digest.blank? || (password.nil? && password_confirmation.present?)
    end

    def password_complexity
      # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
      return if password.blank? || password =~ /(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-])/

      msg = I18n.t('activerecord.errors.messages.complexity')
      errors.add :password, msg
    end
  end
  # rubocop:enable Metrics/BlockLength
end
