class AboutsController < ApplicationController
  layout 'dashboard'
  before_action :set_record, only: %i[update edit create show]
  before_action :set_new_record, only: %i[index new]
  before_action :authenticate_user!
  before_action :confirm_owner, only: %i[update create]

  def index
    render @about.portfolio ? 'edit' : 'new'
  end

  def show
    render 'edit'
  end

  def new
  end

  def edit
  end

  def create
    @about.portfolio = @portfolio

    if @about.save
      redirect_to portfolio_abouts_path(@portfolio)
      flash[:notice] = '"About Me" successfully created!'
    else
      flash[:alert] = @about.errors.full_messages.each{|msg| msg}.join("<br/>").html_safe
      render 'new'
    end
  end

  def update
    if @about.update(about_params)
      redirect_to portfolio_abouts_path(@portfolio)
      flash[:notice] = '"About Me" successfully updated'
    else
      flash[:alert] = @about.errors.full_messages.each{|msg| msg}.join("<br/>").html_safe
      render 'edit'
    end
  end

  private

  def confirm_owner
    unless current_user == Portfolio.find(params[:portfolio_id]).user
      flash[:alert] = 'You are not the owner of that or portfolio'
      redirect_to root
    end
  end

  def set_new_record
    @portfolio = Portfolio.find(params[:portfolio_id])
    @about = @portfolio.about || About.new
  end

  def set_record
    @portfolio = Portfolio.find(params[:portfolio_id])
    @about = params[:id] ? About.find(params[:id]) : @about = About.new(about_params)
  end

  def about_params
    params.require(:about).permit(:about_me, :location, :about_me_brief,
                                  :github, :email, :linkedin, :facebook,
                                  :twitter, :website)
  end
end
