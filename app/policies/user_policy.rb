class UserPolicy < ApplicationPolicy

  def show?
    super || record == user

  end


  def edit?
    user.present? && record == user
  end

  def update?
    edit?
  end

end
