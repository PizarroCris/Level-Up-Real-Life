class BuildingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:profile).where(profiles: { user_id: user.id })
    end
  end

  def index?
    user.present?
  end

  def new?
    user.present?
  end

  def create?
    user.present?
  end

  def upgrade?
    owner?
  end

  def show?
    owner?
  end

  def edit?
    update?
  end

  def update?
    owner?
  end

  private

  def owner?
    record.profile.user == user || user.admin
  end
end
