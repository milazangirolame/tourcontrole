class TourStorePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.order(created_at: :desc)
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.users.include?(user)
  end

  def destroy?
    record.user == user && record.users.find(user).store_creator
  end

  def dashboard?
    record.users.include?(user)
  end


end
