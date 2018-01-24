class FrontEnd::PortfolioController < ApplicationController
  layout 'dashboard', only: [:preview]
  rescue_from Exception, :with => :render_404

  def show
    render_portfolio
  end

  def preview
    render_portfolio
    @portfolios = current_user.portfolios.all
    @dashboard = 'portfolios'
    render 'dashboard/portfolios/preview'
  end

  private

  def render_portfolio
    @portfolio = Portfolio.find_by(url: params[:portfolio])
    @portfolio_header = @portfolio.portfolio_header || filler_header
    @projects = @portfolio.projects.all.order(:order)
    @technologies = @portfolio.technologies.all
    @about = @portfolio.about || filler_about
    @first_name = @portfolio_header.header_one.split(' ').first rescue ''

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

  def render_404
    flash[:alert] = 'This Portfolio does not exist'
    redirect_to root_path
  end

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
end
