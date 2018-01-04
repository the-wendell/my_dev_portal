class Dashboard::TechnologiesController < Dashboard::DashboardController
  before_action :set_record, only: %i[update destroy edit create show]
  before_action :set_new_record, only: %i[index new]
  before_action :confirm_owner, only: %i[create update destroy]

  def index
    render @portfolio.technologies.first ? 'edit' : 'new'
  end

  def show
    render 'edit'
  end

  def new
  end

  def edit
  end

  def create
    if @technology.save
      flash[:notice] = 'Technology successfully added'
      redirect_to portfolio_technologies_path(@portfolio)
    else
      flash[:alert] = helpers.display_errors(@technology)
      render 'new'
    end
  end

  def update
    if @technology.update(technology_params)
      flash[:notice] = 'Technology successfully updated'
      redirect_to portfolio_technologies_path(@portfolio)
    else
      flash[:alert] = helpers.display_errors(@technology)
      render 'edit'
    end
  end

  def destroy
    @technology.destroy
    redirect_to portfolio_technologies_path(@portfolio)
  end

  private

  def confirm_owner
    unless current_user == @technology.portfolio.user
      flash[:alert] = 'You are not the owner of that or portfolio'
      redirect_to root
    end
  end

  def set_record
    @technology = params[:id] ? Technology.find(params[:id]) : @portfolio.technologies.new(technology_params)
    @technologies = @portfolio.technologies.all
  end

  def set_new_record
    @technology = Technology.new
    @technologies = @portfolio.technologies.all
  end

  def technology_params
    params.require(:technology).permit(:name, :years_exp, :proficiency)
  end
end
