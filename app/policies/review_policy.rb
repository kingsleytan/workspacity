class ReviewPolicy < ApplicationPolicy

  def index?
      user.present? && user.moderator? || user.admin? || user.user?
  end

  def new?

    index?
  end

  def create?
    new?
  end

  def edit?

    # user.present? && record.user == user || user_has_power?
    user.present? && record.user_id == user.id || user.moderator? || user.admin?
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end

end
