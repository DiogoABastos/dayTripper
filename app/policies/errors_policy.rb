class ErrorsPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def internal_error?
    true
  end

  def not_found?
    true
  end
end
