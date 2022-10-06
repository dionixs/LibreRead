# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :old_password, :remember_token

  before_update :check_password_changed, if: -> { password.present? }

  has_many :imports, dependent: :destroy
  has_many :notes, dependent: :destroy

  has_secure_password validations: false

  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? }
  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 8, maximum: 70 }
  validate :password_complexity

  validates :email, presence: true, uniqueness: true,
                    'valid_email_2/email': { mx: true }

  def remember_me
    self.remember_token = SecureRandom.urlsafe_base64
    # rubocop:disable Rails/SkipsModelValidations
    update_column :remember_token_digest, digest(remember_token)
    # rubocop:enable Rails/SkipsModelValidations
  end

  def forget_me
    # rubocop:disable Rails/SkipsModelValidations
    update_column :remember_token_digest, nil
    # rubocop:enable Rails/SkipsModelValidations
    self.remember_token = nil
  end

  def remember_token_authenticated?(remember_token)
    return false if remember_token_digest.blank?

    BCrypt::Password.new(remember_token_digest).is_password?(remember_token)
  end

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

  def correct_old_password
    return if BCrypt::Password.new(password_digest_was).is_password?(old_password)

    errors.add :old_password, 'is incorrect'
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
