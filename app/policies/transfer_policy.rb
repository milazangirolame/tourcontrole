class TransferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    manager?(record.tour_store)
  end

  def show?
    manager?(record.tour_store)
  end

  def index?
    manager?(record.tour_store)
  end

end
