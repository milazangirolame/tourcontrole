class BankingInformationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    store_creator?
  end

  def update?
    store_creator?
  end
end
