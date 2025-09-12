class ResourcePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.joins(building: :profile).where(profiles: { user_id: user.id })
    end
  end

  def index?   = user.present?
  def show?    = owns_building?
  def new?     = owns_building?
  def create?  = owns_building?
  def edit?    = owns_building?
  def update?  = owns_building?
  def destroy? = owns_building?

  private

  def owns_building?
    record.building.profile.user_id == user.id
  end
end
