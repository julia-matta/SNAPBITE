class RatingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.customer?
  end

  def new?
    create?
  end

  def destroy?
    user.customer? && record.user == user
  end
end
