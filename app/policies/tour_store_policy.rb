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

  def dashboard?
    store_admin?
  end

  def tours?
    store_admin?
  end

  def users?
    store_admin?
  end

  def events?
    store_admin?
  end

  def bank?
    store_admin?
  end
end
