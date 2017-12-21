class PortfoliosController < ApplicationController
  before_action :set_portfolio, only: %i[update]
  before_action :authenticate_user!, only: %i[update create new destroy]
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
    @portfolio_header = @portfolio.portfolio_header || filler_header
    @projects = @portfolio.projects.all.order(:order)
    @technologies = @portfolio.technologies.all
    @about = @portfolio.about || filler_about
    @first_name = @portfolio_header.header_one.split(' ').first

    if @portfolio.show_years_exp && @portfolio.show_proficiency
      @show_technology = 'all'
    elsif @portfolio.show_years_exp
      @show_technology = 'years'
    elsif @portfolio.show_proficiency
      @show_technology = 'proficiency'
    else
      @show_technology = 'none'
    end
  end

  def destroy
    @portfolio.destroy
    redirect_to root_path
  end

  private

  def filler_about
    About.new(
      about_me: "Go back to your dashboard and create your 'About Me'",
      email: '',
      github: '',
      linkedin: '',
      facebook: '',
      twitter: '',
      website: '',
      about_me_brief: ''
    )
  end

  def filler_header
    PortfolioHeader.new(
      header_one: "Go back to your dashboard and create your 'Portfolio Header'",
      header_two: '',
      header_one_color: '#000000',
      header_two_color: '#000000'
    )
  end

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
                                      :color_three, :color_four,
                                      :font_color_one, :font_color_two,
                                      :show_cover_image, :show_avatar_image,
                                      :show_years_exp, :show_proficiency)
  end
end
