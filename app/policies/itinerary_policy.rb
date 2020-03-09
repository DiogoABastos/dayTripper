class ItineraryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user_owner
  end

  def destroy?
    user_owner
  end

  def clone?
    true
  end

  private

  def user_owner
    user.present? && record.user == user
  end
end
