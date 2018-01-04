class FrontEnd::PortfoliosController < ApplicationController
  layout 'portfolios'

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
end
