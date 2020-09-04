module CompanyHelper
  def current_company
    current_user&.company
  end
end
