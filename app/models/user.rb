# frozen_string_literal: true

class User < ApplicationRecord
  include Avatarable
  include Rememberable

  attr_accessor :old_password

  before_save :set_gravatar_hash, if: :email_changed?
  before_update :check_password_changed, if: -> { password.present? }

  has_many :imports, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :tags, dependent: :delete_all

  has_secure_password validations: false

  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? }
  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 8, maximum: 70 }
  validate :password_complexity

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    'valid_email_2/email': { mx: true }

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

    errors.add :old_password, I18n.t('activerecord.errors.messages.is_incorrect')
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
