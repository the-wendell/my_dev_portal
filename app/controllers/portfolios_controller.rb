class PortfoliosController < ApplicationController
  layout 'dashboard', except: %i[show]
  before_action :set_portfolio, only: %i[new edit update]
  before_action :authenticate_user!, only: %i[update create new destroy]
  before_action :confirm_owner, only: %i[update]

  def new
  end

  def edit
  end

  def create
    new_params = default_params
    new_params[:url] = portfolio_params[:url]
    @portfolio = current_user.portfolios.new(new_params)
    if @portfolio.save
      flash[:notice] = 'New Portfolio Created'
      redirect_to dashboard_index_path
    else
      flash[:alert] = helpers.display_errors(@portfolio)
      redirect_to new_user_portfolio_path(current_user)
    end
  end

  def update
    if @portfolio.update(portfolio_params)
      redirect_to edit_portfolio_path(@portfolio)
      flash[:notice] = 'Portfolio updated successfully'
    else
      flash[:alert] = helpers.display_errors(@portfolio)
      render 'edit'
    end
  end

  def show
    @portfolio = Portfolio.find_by(url: params[:portfolio]) rescue raise('not found')
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
    @portfolio = helpers.active_portfolio
    @portfolios = current_user.portfolios.all
    @themes = Themes.array
  end

  def portfolio_params
    params.require(:portfolio).permit(:url, :theme, :color_one, :color_two,
                                      :color_three, :color_four,
                                      :font_color_one, :font_color_two,
                                      :show_cover_image, :show_avatar_image,
                                      :show_years_exp, :show_proficiency)
  end

  def default_params
    { theme: 'default',
      color_one: '#0a0d72', color_two: '#83c9f4',
      color_three: '#2196f3', color_four: '#00a6fb',
      font_color_one: '#ffffff', font_color_two: '#ffffff',
      show_cover_image: false, show_avatar_image: true,
      show_years_exp: true, show_proficiency: true }
  end
end
