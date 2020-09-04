class ApplicationController < ActionController::Base
  include Pundit
  after_action :verify_authorized, unless: :devise_controller?

  def current_company
    @current_company ||= view_context.current_company
  end
end
