class Management::Engineers::LocationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_engineer, only: [:edit]

  def edit
    @locations = Location.all.map(&:name).join(",")
  end

  private

    def verify_authorized
      authorize [:management, :engineers, :location]
    end

    def set_engineer
      @engineer = current_company.engineers.find_by(uuid: params[:uuid])
    end
end
