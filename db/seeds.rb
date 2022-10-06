# frozen_string_literal: true

User.find_each do |u|
  u.send(:set_gravatar_hash)
  u.save
end
