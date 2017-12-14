class AboutsController < ApplicationController
  before_action :set_about, only: %i[update]
  before_action :authenticate_user!
  before_action :confirm_owner, only: %i[update]

  def create
    @portfolio = current_user.portfolios.first
    @about = About.new(about_params)
    @about.portfolio = @portfolio

    if @about.save
      redirect_to dashboard_index_path(menu_action: 'about')
    else
      flash[:alert] = @about.errors.full_messages.first
      @current_dashboard_action = 'about'
      render 'dashboard/index'
    end
  end

  def update
    unless @about.update(about_params)
      flash[:alert] = @about.errors.full_messages.first
    end
    redirect_to dashboard_index_path(menu_action: 'about')
  end

  private

  def confirm_owner
    unless current_user == @about.portfolio.user
      flash[:alert] = 'You are not the owner of that portfolio'
      redirect_to root
    end
  end

  def set_about
    @about= About.find(params[:id])
  end

  def about_params
    params.require(:about).permit(:about_me, :location, :about_me_brief,
                                  :github, :email, :linkedin, :facebook,
                                  :twiter, :website)
  end
end
