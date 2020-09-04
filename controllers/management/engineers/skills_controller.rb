class Management::Engineers::SkillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_engineer, only: [:edit]

  def edit
    @skills = Skill.all.map(&:name).join(",")
  end

  private

    def verify_authorized
      authorize [:management, :engineers, :skill]
    end

    def set_engineer
      @engineer = current_company.engineers.find_by(uuid: params[:uuid])
    end
end
