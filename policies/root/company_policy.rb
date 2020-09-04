class Root::CompanyPolicy < ApplicationPolicy
  def index?
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

  private

    def authorized_user
      user.root_role_admin? or user.root_role_manager?
    end
end
