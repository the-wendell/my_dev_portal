class Dashboard::UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    @user = current_user
    @user.options[:active_portfolio_id] = params[:id]
    if @user.save
      flash[:notice] = "Active portfolio changed to #{Portfolio.find(@user.options[:active_portfolio_id]).url}"
    else
      flash[:alert] = "Doh! Something went wrong..."
    end
    redirect_to dashboard_index_path
  end
end
