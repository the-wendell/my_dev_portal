class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_dashboard_action = params[:menu_action] || 'dashboard_home'
    @portfolio = current_user.portfolios.first
    @projects = @portfolio.projects.all.order(:order)
    @project = params[:project_id] ? Project.find(params[:project_id]) : Project.new
    @technologies = @portfolio.technologies.all
    @technology = params[:technology_id] ? Technology.find(params[:technology_id]) : Technology.new
  end
end
