class Dashboard::DashboardController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!, :set_portfolios, :confirm_portfolio_owner

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

  def set_portfolios
    @portfolio = helpers.active_portfolio
    @portfolios = current_user.portfolios.all
  end

  def confirm_portfolio_owner
    unless current_user == @portfolio.user
      flash[:alert] = 'You are not the owner of that or portfolio'
      redirect_to root
    end
  end
end
