class ProjectsController < ApplicationController
  before_action :set_project, only: %i[update destroy]
  before_action :authenticate_user!
  before_action :confirm_owner, only: %i[update destroy]

  def create
    @portfolio = current_user.portfolios.first
    @project = @portfolio.projects.new(project_params)

    if @project.save
      redirect_to dashboard_index_path(menu_action: 'projects_view')
    else
      flash[:alert] = @project.errors.full_messages.first
      @current_dashboard_action = 'projects_view'
      render 'dashboard/index'
    end
  end

  def update
    if @project.update(project_params)
      redirect_to dashboard_index_path(menu_action: 'projects_view')
    else
      flash[:alert] = @project.errors.full_messages.first
      redirect_to dashboard_index_path(menu_action: 'projects_view', id: @project.id)
    end
  end

  def destroy
    @project.destroy
    redirect_to dashboard_index_path(menu_action: 'projects_view')
  end

  private

  def confirm_owner
    unless current_user == @project.portfolio.user
      flash[:alert] = 'You are not the owner of that project or portfolio'
      redirect_to root
    end
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:references, :title, :link, :descrption,
                                    :image, :tech, :role, :order)
  end
end
