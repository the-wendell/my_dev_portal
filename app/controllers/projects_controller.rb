class ProjectsController < ApplicationController
  before_action :set_project, only: [:update, :destroy]
  before_action :authenticate_user!

  def create
    @portfolio = current_user.portfolios.first
    @project = @portfolio.projects.new(project_params)

    if @project.save
      redirect_to dashboard_index_path(menu_action: 'view_projects')
    else
      flash[:alert] = 'There was an error creating the project.  Please try again'
      redirect_to dashboard_index_path(menu_action: 'add_project')
    end
  end

  def update
    if @project.update(project_params)
      redirect_to dashboard_index_path(menu_action: 'view_projects')
    else
      flash[:alert] = 'There was an error updating the project.  Please try again'
      redirect_to dashboard_index_path(menu_action: 'edit_project', id: @project.id)
    end
  end

  def destroy
    @project.destroy
    redirect_to dashboard_index_path(menu_action: 'view_projects')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:references, :title, :link, :descrption, :image, :tech, :role)
    end
end
