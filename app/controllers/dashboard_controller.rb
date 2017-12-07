class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_dashboard_action = params[:menu_action] || 'dashboard_home'
  end
end
