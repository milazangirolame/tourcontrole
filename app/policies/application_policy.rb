class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def manager?(store)
    store.tour_store_admins.find_by(user: user).manager
  end

  def admin?(store)
    store.users.include?(user)
  end

  def store_admin?
    record.kind_of?(TourStore) ? admin?(record) : admin?(record.tour_store)
  end

  def store_manager?
    record.kind_of?(TourStore) ? manager?(record) : manager?(record.tour_store)
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
