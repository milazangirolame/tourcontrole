class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.order(starts_at: :desc)
    end
  end

  def show?
    true
  end

  def create?
    store_admin?
  end

  def update?
    store_admin?
  end

  def destroy?
    store_admin?
  end

  def audit?
    store_admin?
  end
end
