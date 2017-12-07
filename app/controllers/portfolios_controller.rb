class PortfoliosController < ApplicationController
  def create
    @portfolio = current_user.portfolios.new
    @portfolio.url = params[:portfolio][:url]
    if @portfolio.save
      flash[:notice] = 'New Portfolio Created'
    else
      flash[:alert] = `There was an error creating your portfolio`
    end
  end

  def update
    @portfolio = current_user.portfolios.first
  end

  def show
    @portfolio = Portfolio.find_by(url: params[:portfolio]) || raise('not found')
  end
end
