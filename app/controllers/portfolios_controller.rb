class PortfoliosController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @portfolio = current_user.portfolios.new
    @portfolio.url = params[:portfolio][:url]
    if current_user.portfolios.count > 0
      flash[:alert] = 'Only one portfolio allowed per user at this time'
      render 'new'
    elsif @portfolio.save
      flash[:notice] = 'New Portfolio Created'
      redirect_to dashboard_index_path
    else
      flash[:alert] = @portfolio.errors.full_messages.first
      render 'new'
    end
  end

  def update
    @portfolio = current_user.portfolios.first
    @portfolio.url = params[:portfolio][:url]
    unless @portfolio.save
      flash[:alert] = @portfolio.errors.full_messages.first
    end
    redirect_to dashboard_index_path(menu_action: 'change_portfolio_url')
  end

  def show
    @portfolio = Portfolio.find_by(url: params[:portfolio]) || raise('not found')
  end
end
