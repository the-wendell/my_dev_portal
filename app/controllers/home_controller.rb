class HomeController < ApplicationController
  def index
    if current_user
      redirect_to user_dashboard_index_path(current_user)
    end
  end
end
