class Management::ResumeUploadersController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end

  def create
    family_name = FamilyName.new
    
    params[:files].each do |file|
      next if file.blank?

      engineer = nil
      if params[:uuid].present?
        engineer = current_company.engineers.find_by(uuid: params[:uuid])
      end
      engineer ||= current_company.engineers.build(privacy: :unlisted)
      resume = engineer.resumes.build(file: file)

      if engineer.new_record?
        hash = family_name.match_name(resume.file.original_filename)
        engineer.full_name = hash[:name]

        engineer.full_name = hash[:display_name] if engineer.full_name.blank?
        engineer.display_name = hash[:display_name]
      end

      # PDFの場合はそのままコピーして、変換済みフラグを立てる
      if resume.file.metadata["mime_type"] == "application/pdf"
        resume.file_derivatives!
        resume.converted = true
        # resume.raw_text = resume.extract_text
      end

      engineer.save!
    end

    redirect_to management_engineers_path, notice: "スキルシートをアップロードしました"
  end

  private

    def verify_authorized
      authorize [:management, :resume_uploader]
    end
end
