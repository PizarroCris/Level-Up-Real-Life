class GuildPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.profile.guild.nil?
  end

  def new?
    create?
  end

  def join?
    user.profile.guild_membership.nil?
  end

  def leave?
    user.profile.guild_membership.present?
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

  private

  def owner?
    record.leader.user == user || user.admin?
  end
end
