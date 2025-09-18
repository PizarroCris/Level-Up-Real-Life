class WorldMonsterPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def attack?
    true
  end
end
