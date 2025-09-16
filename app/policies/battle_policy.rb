class BattlePolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
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
