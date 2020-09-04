class ResumePolicy < ApplicationPolicy
  def show?
    true
  end

  def destroy?
    user.role_admin?
  end
end
