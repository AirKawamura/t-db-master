class EngineersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_engineer, only: [:show]

  def index
    # p params
    @engineers = Engineer.privacy_public
    
    if params[:search]
      condition = []
      
      # 希望単価
      @min_price = search_params[:min_price]
      @max_price = search_params[:max_price]
      condition << {price: {gteq: @min_price.to_i}} if @min_price.present?
      condition << {price: {lteq: @max_price.to_i}} if @max_price.present?

      # 商流
      @commercial_distribution = search_params[:commercial_distribution]
      if @commercial_distribution.present?
        condition << {commercial_distribution: {lteq: @commercial_distribution.to_i}}
        condition << {commercial_distribution: {gt: 0}}
      end

      # p condition
      @engineers = @engineers.search(and: condition) if condition.size > 0

      # 職種
      @career_role = search_params[:career_role]
      @engineers = @engineers.tagged_with(@career_role, on: :career_roles, any: true) if @career_role.present?

      # スキル
      @skill = search_params[:skill]
      @engineers = @engineers.tagged_with(@skill.split(","), on: :skills, any: true) if @skill.present?

      # 勤務可能エリア
      @location = search_params[:location]
      @engineers = @engineers.tagged_with(@location.split(","), on: :locations, any: true) if @location.present?
    end

    @engineers = @engineers.order(created_at: :desc)
    @career_roles = CareerRole.all.map(&:name)
    @skill_list = Skill.all.map(&:name).join(",")
    @location_list = Location.all.map(&:name).join(",")
    @price_list = (5..20).map {|i| ["#{i * 10}万円", i * 10]}
    @commercial_distribution_list = { "直請けのみ": 1, "1社下まで": 2, "2社下まで": 3 }
  end

  def show
    @resume = @engineer.resumes.first
  end

  private

    def verify_authorized
      authorize [:engineer]
    end

    def set_engineer
      @engineer = Engineer.find_by(uuid: params[:uuid])
    end

    def search_params
      params.require(:search).permit(:min_price, :max_price, :commercial_distribution, :skill, :location, career_role: [])
    end
end
