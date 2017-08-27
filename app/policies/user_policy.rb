class UserPolicy < ApplicationPolicy

  # Only allow user to view own profile unless admin
  def show?
   record == user
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def create?
    false
  end

  def destroy?
    show?
  end

  def index?
    false
  end
end
