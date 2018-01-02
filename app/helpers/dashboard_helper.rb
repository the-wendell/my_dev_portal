module DashboardHelper
  def active_portfolio
    Portfolio.find(current_user.options[:active_portfolio_id]) rescue current_user.portfolios.first
  end
end
