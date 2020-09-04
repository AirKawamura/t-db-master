class Management::EngineersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_engineer, only: [:show, :edit, :update, :destroy]

  def index
    @engineers = current_company.engineers.includes(:resumes).all.order(created_at: :desc)
  end

  def show
  end

  # def new
  #   @engineer = current_company.engineers.build
  # end

  # def edit
  # end

  # def create
  #   @engineer = current_company.engineers.build(engineer_params)

  #   if @engineer.save
  #     redirect_to management_engineers_url, notice: "エンジニアを登録しました"
  #   else
  #     render :new
  #   end
  # end

  def update
    @engineer.update(engineer_params)
    # if @engineer.update(engineer_params)
    #   redirect_to management_engineers_url, notice: 'Engineer was successfully updated.'
    # else
    #   render :edit
    # end
  end

  def destroy
    @engineer.destroy
    redirect_to management_engineers_url, notice: "エンジニアを削除しました"
  end

  def bulk_edit
    gon.grid_header = {
      uuid: "エンジニアID", privacy_i18n: "公開設定", full_name: "氏名", full_name_kana: "ふりがな", display_name: "公開する名前",
      birth_at: "生年月日", gender_i18n: "性別", nationality: "国籍", employment_type_i18n: "雇用形態", provider: "所属会社",
      commercial_distribution_i18n: "商流", price: "希望単価", remarks: "特記事項"
    }

    gon.grid_data = current_company.engineers.order(created_at: :desc).map {|e| [
      e.uuid, e.privacy_i18n, e.full_name, e.full_name_kana, e.display_name, (e.birth_at ? l(e.birth_at) : nil), e.gender_i18n,
      e.nationality, e.employment_type_i18n, e.provider, e.commercial_distribution_i18n, e.price, e.remarks
    ]}
    
    gon.countries = Country.all.map(&:name)
    gon.privacies = Engineer.privacies_i18n.values
    gon.genders = Engineer.genders_i18n.values
    gon.employment_types = Engineer.employment_types_i18n.values
    gon.commercial_distributions = Engineer.commercial_distributions_i18n.values
  end

  def bulk_update
    params["data"].values.each do |uuid, key, value|
      v = value
      if key.end_with?("_i18n")
        next unless %w(privacy_i18n gender_i18n employment_type_i18n commercial_distribution_i18n).include?(key)

        org_key = "#{key.sub('_i18n', '')}"               # ex) gender
        hash = Engineer.try("#{org_key.pluralize}_i18n")  # ex) genders_i18n

        if value.blank?
          new_params = {org_key => hash.keys[0]}
        else
          new_params = {org_key => hash.invert[value]}
        end
      else
        new_params = {key.to_sym => value}
      end

      Engineer.find_by(uuid: uuid).update(new_params)
    end
  end

  private

    def verify_authorized
      authorize [:management, :engineer]
    end

    def set_engineer
      @engineer = current_company.engineers.find_by(uuid: params[:uuid])
    end
    
    def engineer_params
      params.require(:engineer).permit(:privacy, :full_name, :full_name_kana, :display_name, :gender, :birth_at, :age, :nationality,
        :employment_type, :provider, :commercial_distribution, :price, :remarks, :career_role_list, :skill_list, :location_list)
    end
end
