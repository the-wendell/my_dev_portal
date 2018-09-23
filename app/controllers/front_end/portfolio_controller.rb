class FrontEnd::PortfolioController < ApplicationController
  layout 'dashboard', only: [:preview]
  rescue_from Exception, :with => :render_404
  before_action :render_portfolio

  def show; end

  def preview
    @portfolios = current_user.portfolios.all
    @dashboard = 'portfolios'
    render 'dashboard/portfolios/preview'
  end

  private

  def render_portfolio
    @portfolio = Portfolio.find_by(url: params[:portfolio])

    @portfolio_header = @portfolio.render_header
    @projects = @portfolio.render_projects
    @technologies = @portfolio.render_technologies
    @about = @portfolio.render_about
    @first_name = @portfolio.render_first_name
    @show_technology = @portfolio.render_show_technology
  end

  def render_404
    flash[:alert] = 'This Portfolio does not exist'
    redirect_to root_path
  end
end
