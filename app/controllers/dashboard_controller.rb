class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_dashboard_action = params[:menu_action] || 'dashboard_home'
    @themes = Themes.array

    @portfolio = current_user.portfolios.first
    @portfolio_header = @portfolio.portfolio_header || PortfolioHeader.new
    @about = @portfolio.about || About.new

    @projects = @portfolio.projects.all.order(:order)
    @project = params[:project_id] ? Project.find(params[:project_id]) : Project.new

    @technologies = @portfolio.technologies.all
    @technology = params[:technology_id] ? Technology.find(params[:technology_id]) : Technology.new

    if @portfolio_header.header_one && @about.about_me && (@technologies.count > 0) && (@projects.count > 0)
      @new_user = false
    else
      @new_user = true
    end
  end
end
