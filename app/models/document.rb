class Document < ApplicationRecord
  validates :filename, presence: true, length: { in: 1..200 }
  validates :mime_type, presence: true
  validates :data, presence: true
  validate :check_file_type

  def check_file_type
    errors.add(:document, 'Must be a Txt file') unless mime_type.in?(%w[text/plain])
  end
end
