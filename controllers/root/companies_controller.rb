class Root::CompaniesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to root_companies_url, notice: "企業を登録しました"
    else
      render :new
    end
  end

  def update
    if @company.update(company_params)
      redirect_to root_companies_url, notice: "更新しました"
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to root_companies_url, notice: "企業を削除しました"
  end

  private

    def verify_authorized
      authorize [:root, :company]
    end

    def set_company
      @company = Company.find(params[:id])
    end

    def company_params
      params.require(:company).permit(:name, :engineer_management, :job_management)
    end
end
