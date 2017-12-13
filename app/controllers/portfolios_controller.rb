class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[update]
  before_action :authenticate_user!
  before_action :confirm_owner, only: %i[update]

  def new
  end

  def create
    @portfolio = current_user.portfolios.new(portfolio_params)
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
    unless @portfolio.update(portfolio_params)
      flash[:alert] = @portfolio.errors.full_messages.first
    end
    redirect_to dashboard_index_path(menu_action: 'portfolio_config')
  end

  def show
    @portfolio = Portfolio.find_by(url: params[:portfolio]) || raise('not found')
  end

  private

  def confirm_owner
    unless current_user == @portfolio.user
      flash[:alert] = 'You are not the owner of that or portfolio'
      redirect_to root
    end
  end

  def set_portfolio
    @portfolio = current_user.portfolios.first
  end

  def portfolio_params
    params.require(:portfolio).permit(:url, :theme, :color_one, :color_two,
                                      :color_three, :color_four)
  end
end
