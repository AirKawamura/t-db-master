module EngineerHelper
  def gender_icon(gender)
    case gender.to_sym
    when :male
      icon("fas", "male", style: "color: blue;")
    when :female
      icon("fas", "female", style: "color: red;")
    else
      nil
    end
  end
end
