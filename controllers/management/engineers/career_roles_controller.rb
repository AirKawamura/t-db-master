class Management::Engineers::CareerRolesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_engineer, only: [:edit]

  def edit
    @career_roles = CareerRole.all.map(&:name).join(",")
  end

  private

    def verify_authorized
      authorize [:management, :engineers, :career_role]
    end

    def set_engineer
      @engineer = current_company.engineers.find_by(uuid: params[:uuid])
    end
end
