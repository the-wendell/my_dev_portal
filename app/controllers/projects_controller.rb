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
      flash[:alert] = 'There was an error creating the project.  Please try again'
      redirect_to dashboard_index_path(menu_action: 'add_project')
    end
  end

  def update
    if @project.update(project_params)
      redirect_to dashboard_index_path(menu_action: 'projects_view')
    else
      flash[:alert] = 'There was an error updating the project.  Please try again'
      redirect_to dashboard_index_path(menu_action: 'edit_project', id: @project.id)
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
                                      :image, :tech, :role)
    end
end
