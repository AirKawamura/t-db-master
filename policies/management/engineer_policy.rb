class Management::EngineerPolicy < ApplicationPolicy
  def index?
    authorized_user
  end

  def show?
    authorized_user
  end

  def new?
    authorized_user
  end

  def edit?
    authorized_user
  end

  def create?
    authorized_user
  end

  def update?
    authorized_user
  end

  def destroy?
    authorized_user
  end

  def bulk_edit?
    authorized_user
  end

  def bulk_update?
    authorized_user
  end

  private

    def authorized_user
      user.role_admin?
    end
end
