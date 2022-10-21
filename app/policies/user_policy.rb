# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def create?
    user.guest?
  end

  def update?
    access_allowed?
  end

  def destroy?
    access_allowed?
  end

  def index?
    false
  end

  def show?
    true
  end

  private

  def access_allowed?
    user.admin_role? || user.moderator_role? || user.owner?(record)
  end
end
