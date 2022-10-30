# frozen_string_literal: true

class User < ApplicationRecord
  include Accessible
  include Avatarable
  include Rememberable
  include Recoverable
  include Password

  attr_accessor :admin_edit, :admin_id, :admin_password

  enum role: { admin: 'admin', moderator: 'moderator', basic: 'basic' }, _suffix: :role
  enum status: { active: 'active', banned: 'banned' }, _suffix: :status

  before_save :set_gravatar_hash, if: :email_changed?
  before_update :check_password_changed, if: -> { password.present? }

  has_many :imports, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :tags, dependent: :delete_all

  has_secure_password validations: false

  validates :admin_password, presence: true, if: -> { admin_edit }
  validate :correct_admin_password, on: :update, if: -> { admin_password.present? }
  validate :password_presence
  validate :correct_old_password, on: :update, if: -> { password.present? && !admin_edit }
  validates :password, confirmation: true, allow_blank: true,
                       length: { minimum: 8, maximum: 70 }
  validate :password_complexity

  validates :email, presence: true, uniqueness: { case_sensitive: false },
                    'valid_email_2/email': { mx: true }
  validates :role, presence: true
  validates :status, presence: true

  alias active? active_status?
  alias banned? banned_status?
end
