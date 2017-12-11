class TechnologiesController < ApplicationController
  before_action :set_project, only: %i[update destroy]
  before_action :authenticate_user!
  before_action :confirm_owner, only: %i[update destroy]

  def create
    @portfolio = current_user.portfolios.first
    @technology = @portfolio.technologies.new(technology_params)

    unless @technology.save
      flash[:alert] = 'There was an error creating the project.  Please try again'
    end
    redirect_to dashboard_index_path(menu_action: 'technologies')
  end

  def update
    if @technology.update(technology_params)
      redirect_to dashboard_index_path(menu_action: 'technologies')
    else
      flash[:alert] = 'There was an error updating.  Please try again'
      redirect_to dashboard_index_path(menu_action: 'technologies', id: @technology.id)
    end
  end

  def destroy
    @technology.destroy
    redirect_to dashboard_index_path(menu_action: 'technologies')
  end

  private

  def confirm_owner
    unless current_user == @technology.portfolio.user
      flash[:alert] = 'You are not the owner of that technology or portfolio'
      redirect_to root
    end
  end

  def set_project
    @technology = Technology.find(params[:id])
  end

  def technology_params
    params.require(:technology).permit(:name, :years_exp, :proficiency,
                                       :show_years_exp, :show_proficiency)
  end
end
