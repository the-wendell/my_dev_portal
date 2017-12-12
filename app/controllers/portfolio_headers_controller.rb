class PortfolioHeadersController < ApplicationController
  before_action :set_portfolio_header, only: %i[update]
  before_action :authenticate_user!
  before_action :confirm_owner, only: %i[update]

  def create
    @portfolio = current_user.portfolios.first
    @portfolio_header = PortfolioHeader.new(portfolio_header_params)
    @portfolio_header.portfolio = @portfolio

    unless @portfolio_header.save
      flash[:alert] = @portfolio_header.errors.full_messages.first
    end
    redirect_to dashboard_index_path(menu_action: 'portfolio_header')
  end

  def update
    unless @portfolio_header.update(portfolio_header_params)
      flash[:alert] = @portfolio_header.errors.full_messages.first
    end
    redirect_to dashboard_index_path(menu_action: 'portfolio_header')
  end

  private

  def confirm_owner
    unless current_user == @portfolio_header.portfolio.user
      flash[:alert] = 'You are not the owner of that portfolio'
      redirect_to root
    end
  end

  def set_portfolio_header
    @portfolio_header= PortfolioHeader.find(params[:id])
  end

  def portfolio_header_params
    params.require(:portfolio_header).permit(:header_one, :header_two,
                                    :cover_image, :avatar_image,
                                    :header_one_color, :header_two_color)
  end
end
