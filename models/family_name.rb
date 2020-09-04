class FamilyName
  attr_accessor :family_names

  def initialize
    @family_names = FamilyName.load_data
  end

  def match_name(str)
    str = str.sub("株式会社", "") # "式"という苗字があるため

    # マッチした中で一番文字数が多い苗字を採用
    match = @family_names.select {|n| str.include?(n)}
    family_name = match.max {|a, b| a.length <=> b.length}

    res = { name: nil, display_name: nil }
    if family_name
      # 苗字を頼りにフルネームを抽出
      /(#{family_name}\p{blank}*(\p{Hiragana}|\p{Katakana}|[一-龠々]|)*)/ =~ str
      n = $1
      n.sub!(/(さん|様)$/, "")
      n.sub!(/[\s　]/, "")
      first_name = n.delete(family_name) # 名前のみ抽出

      res[:name] = "#{family_name} #{first_name}"
    else
      # 苗字がマッチしなかった場合はイニシャルを抽出
      /[^A-Z]([A-Z]\.[A-Z])[^A-Z]/ =~ str
      res[:display_name] = $1
    end
    res
  end

  def self.load_data
    path = Rails.root.join('lib/assets/family_names.csv')
    arr = []
    File.foreach(path) {|line|
      arr << line.chop
    }
    arr
  end
end
