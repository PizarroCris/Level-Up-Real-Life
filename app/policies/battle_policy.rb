class BattlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(attacker: user.profile).or(scope.where(defender: user.profile))
    end
  end

  def create?
    record.defender != user.profile
  end

  def new?
    create?
  end

  def show?
    record.attacker == user.profile || record.defender == user.profile
  end
end
