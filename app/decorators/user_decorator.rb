# frozen_string_literal: true

class UserDecorator < ApplicationDecorator
  delegate_all

  def name_or_email
    return name if name.present?

    email.split('@')[0]
  end

  def gravatar(size: 30, css_class: '')
    email_hash = Digest::MD5.hexdigest(email.strip.downcase)
    h.image_tag "https://www.gravatar.com/avatar/#{email_hash}.jpg?d=retro&s=#{size}&f=y",
                class: css_class, alt: name_or_email
  end
end
