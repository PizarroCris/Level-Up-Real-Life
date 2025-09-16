class GuildMembershipPolicy < ApplicationPolicy
  def destroy?
    record.guild.leader.user == user
  end
end
