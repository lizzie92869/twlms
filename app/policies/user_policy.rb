class UserPolicy < ApplicationPolicy

  # Only allow user to view own profile unless admin
  def show?
   user.admin? || record == user
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def create?
    user.admin?
  end

  def destroy?
    show?
  end

  def index?
    user.admin?
  end
end
