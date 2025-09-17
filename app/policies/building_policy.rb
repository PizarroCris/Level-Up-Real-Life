class BuildingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
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

  def collect_resources?
    owner?
  end

  private

  def owner?
    record.profile.user == user || user.admin
  end
end
