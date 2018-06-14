class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def creator?(store)
    store.tour_store_admins.find_by(user: user).store_creator
  end

  def admin?(store)
    store.users.include?(user)
  end

  def store_admin?
    record.kind_of?(TourStore) ? admin?(record) : admin?(record.tour_store)
  end

  def store_creator?
    record.kind_of?(TourStore) ? creator?(record) : creator?(record.tour_store)
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists?
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
