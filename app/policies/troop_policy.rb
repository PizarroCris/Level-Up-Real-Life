class TroopPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(:building).where(buildings: { profile_id: user.profile.id })
    end
  end

  def create?
    record.building.profile == user.profile
  end
end
