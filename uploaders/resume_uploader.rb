class ResumeUploader < Shrine
  plugin :derivatives
  plugin :delete_raw
  plugin :pretty_location
  plugin :determine_mime_type #, analyzer: :marcel

  # PDFの場合は元ファイルをそのままpreviewにコピー
  Attacher.derivatives do |original|
    {
      preview: File.open(original)
    }
  end
end
