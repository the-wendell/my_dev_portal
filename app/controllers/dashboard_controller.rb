class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_dashboard_action = params[:menu_action] || 'dashboard_home'
    @portfolio = current_user.portfolios.first
    @projects = @portfolio.projects.all
  end
end
