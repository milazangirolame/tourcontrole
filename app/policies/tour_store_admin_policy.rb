class TourStoreAdminPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end


  def create?
    store_manager?
  end

  def update?
    store_manager?
  end

  def destroy?
    store_manager?
  end
end
