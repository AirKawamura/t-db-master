class Management::ResumeUploaderPolicy < ApplicationPolicy
  def show?
    authorized_user
  end

  def create?
    authorized_user
  end

  private

    def authorized_user
      user.role_admin?
    end
end
