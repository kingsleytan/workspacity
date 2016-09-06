class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def dashboard?
    user.admin?
  end

  def index?
    dashboard?
  end

  def show?
    scope.where(:id => record.id).exists? && dashboard?
  end

  def new?
    dashboard?
  end

  def edit?
    dashboard?
  end

  def destroy?
    dashboard?
  end

  def export?
    dashboard?
  end

  def history?
    dashboard?
  end

  def show_in_app?
    dashboard?
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
