class TourStorePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(dummy:false).order(created_at: :desc)
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    store_admin?
  end

  def destroy?
    record.user == user && record.users.find(user).store_creator
  end

  def dashboard?
    store_admin?
  end

  def tours?
    store_admin?
  end

  def users?
    store_admin?
  end
end
