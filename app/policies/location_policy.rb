class LocationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    user_owner
  end

  def update?
    user_owner
  end

  def destroy?
    user_owner
  end

  def change_order?
    true
  end

  private

  def user_owner
    user.present?
  end
end
