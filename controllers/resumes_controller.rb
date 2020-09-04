class ResumesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_engineer, only: [:show, :destroy]
  before_action :set_resume, only: [:show, :destroy]

  def show
  end

  def destroy
    @resume.destroy
    redirect_to management_engineers_url, notice: "スキルシートを削除しました"
  end

  private

    def verify_authorized
      authorize [:resume]
    end

    def set_engineer
      @engineer = Engineer.find_by(uuid: params[:engineer_uuid])
    end

    def set_resume
      @resume = @engineer.resumes.find(params[:id])
    end
end
