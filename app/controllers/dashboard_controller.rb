class DashboardController < ApplicationController
  before_action :authenticate_user!, :set_portfolio

  def index
    @portfolio_header = @portfolio.portfolio_header || PortfolioHeader.new
    @about = @portfolio.about || About.new
    @projects = @portfolio.projects.all.order(:order)
    @technologies = @portfolio.technologies.all

    if @portfolio_header.header_one && @about.about_me && (@technologies.count > 0) && (@projects.count > 0)
      @new_user = false
    else
      @new_user = true
    end
  end
  private

  def set_portfolio
    @portfolio = helpers.active_portfolio
  end
end
