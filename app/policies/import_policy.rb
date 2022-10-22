# frozen_string_literal: true

class ImportPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    access_allowed?
  end

  def create?
    access_allowed?
  end

  def upload?
    access_allowed?
  end

  def download?
    access_allowed?
  end

  def destroy?
    access_allowed?
  end

  private

  def access_allowed?
    user.admin_role? || user.moderator_role? || (user.active? && user.author?(record))
  end
end
