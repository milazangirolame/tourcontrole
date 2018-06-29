class TransferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    creator?(record.tour_store)
  end

  def show?
    creator?(record.tour_store)
  end

  def index?
    creator?(record.tour_store)
  end

end
