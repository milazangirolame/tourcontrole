class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def create?
    true
  end

  def update?
    admin?(record.tour_store)
  end

  def destroy?
    admin?(record.tour_store)
  end

  def show?
    admin?(record.tour_store)
  end

end
