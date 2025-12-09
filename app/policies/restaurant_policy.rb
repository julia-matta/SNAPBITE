class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.owner?
        scope.where(user: user)      # dono vê só os próprios restaurantes
      else
        scope.all                    # customer vê todos
      end
    end
  end

  def show?
    true                             # qualquer logado pode ver
  end

  def create?
    user.owner?                      # só dono cria restaurante
  end

  def new?
    create?
  end

  def update?
    user.owner? && record.user == user
  end

  def edit?
    update?
  end

  def destroy?
    user.owner? && record.user == user
  end
end
