class Resume < ApplicationRecord
  belongs_to :engineer

  include ResumeUploader::Attachment(:file)

  def make_preview
    p "converting resume.id = #{id}"

    # オリジナルファイルをS3からダウンロード
    ext = File.extname(file.original_filename)
    original_path = Rails.root.join("tmp", "converted", "resume#{id}#{ext}")
    file.open {|io|
      open(original_path, "wb") do |out|
        out.write(io.read)
      end
    }

    # PDFに変換
    converted_filename = "#{SecureRandom.uuid}.pdf"
    converted_path = Rails.root.join("tmp", "converted", converted_filename)
    Libreconv.convert(original_path, converted_path)

    # 変換したファイルをS3にアップロード
    file_attacher.add_derivatives(preview: File.open(converted_path))
    self.converted = true
    save

    p "converted successfully resume.id = #{id}"
  end

  def extract_text
    p "extracting resume.id = #{id}"

    unless converted
      p "skip"
      return
    end

    output = ""
    file(:preview).download do |file|
      File.open(file, "rb") do |io|
        reader = PDF::Reader.new(io)
        reader.pages.each do |page|
          output << page.text
        end
      end
    end

    p "extracted resume.id = #{id}"
    output
  end
end
