# frozen_string_literal: true

class NotePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    access_allowed?
  end

  def update?
    access_allowed?
  end

  def destroy?
    access_allowed?
  end

  private

  def access_allowed?
    user.admin_role? || user.moderator_role? || user.author?(record)
  end
end
