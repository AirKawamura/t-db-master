class Management::Engineers::LocationPolicy < ApplicationPolicy
  def edit?
    authorized_user
  end

  private

    def authorized_user
      user.role_admin?
    end
end
