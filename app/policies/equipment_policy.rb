# app/policies/equipment_policy.rb
class EquipmentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(profile: user.profile)
    end
  end

  def create?
    record.profile == user.profile
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.profile.user == user
  end
end
