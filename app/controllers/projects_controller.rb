class ProjectsController < ApplicationController
  layout 'dashboard'
  before_action :set_record, only: %i[update destroy edit create show]
  before_action :set_new_record, only: %i[index new]
  before_action :authenticate_user!
  before_action :confirm_owner, only: %i[create update destroy]

  def index
    render 'new'
  end

  def show
    render 'edit'
  end

  def new
  end

  def edit
  end

  def create
    if @project.save
      flash[:notice] = 'Project successfully added'
      redirect_to portfolio_projects_path(@portfolio)
    else
      flash[:alert] = @project.errors.full_messages.each{|msg| msg}.join("<br/>").html_safe
      render 'new'
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Project successfully updated'
      redirect_to portfolio_projects_path(@portfolio)
    else
      flash[:alert] = @project.errors.full_messages.each{|msg| msg}.join("<br/>").html_safe
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    redirect_to portfolio_projects_path(@portfolio)
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
    @projects = @portfolio.projects.all
    @project = Project.new
  end

  def set_record
    @portfolio = Portfolio.find(params[:portfolio_id])
    @project = params[:id] ? Project.find(params[:id]) : @portfolio.projects.new(project_params)
    @projects = @portfolio.projects.all
  end

  def project_params
    params.require(:project).permit(:references, :title, :link, :description,
                                    :image, :tech, :role, :order)
  end
end
