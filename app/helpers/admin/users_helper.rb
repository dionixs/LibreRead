# frozen_string_literal: true

module Admin
  module UsersHelper
    def user_roles
      User.roles.keys.map do |role|
        [t(role, scope: 'global.user.roles'), role]
      end
    end

    def user_statuses
      User.statuses.keys.map do |status|
        [t(status, scope: 'global.user.statuses'), status]
      end
    end
  end
end
