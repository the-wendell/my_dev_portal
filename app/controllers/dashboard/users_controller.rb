class Dashboard::UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user
    @user.options[:active_portfolio_id] = params[:id]
    @active_portfolio_url = Portfolio.find(@user.options[:active_portfolio_id]).url
    if @user.save
      flash[:notice] = "Active portfolio changed to #{@active_portfolio_url}"
    else
      flash[:alert] = 'Doh! Something went wrong...'
    end

    if request.referrer.split('/')[3] == 'preview'
      redirect_to "/preview/#{@active_portfolio_url}"
    else
      redirect_to request.referrer
    end
  end
end
