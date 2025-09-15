class ProfilePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    owner?
  end

  def create?
    user.profile.nil?
  end

  def new?
    create?
  end

  def update?
    owner?
  end

  def edit?
    update?
  end

  def destroy?
    owner?
  end

  def inventory
    owner?
  end

  private

  def owner?
    record.user == user || user.admin
  end
end
