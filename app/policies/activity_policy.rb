class ActivityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all.order(start_date: :desc)
    end
  end


  def show?
    true
  end

  def create?
    record.tour_store.users.include?(user)
  end

  def update?
    record.tour_store.users.include?(user)
  end

  def destroy?
    record.tour_store.users.include?(user)
  end



end
