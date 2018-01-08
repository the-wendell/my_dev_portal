class Dashboard::AboutsController < Dashboard::DashboardController
  before_action :set_record, only: %i[update edit create show]
  before_action :set_new_record, only: %i[index new]
  before_action :confirm_owner, only: %i[update]

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
      flash[:alert] = helpers.display_errors(@about)
      render 'new'
    end
  end

  def update
    if @about.update(about_params)
      redirect_to portfolio_abouts_path(@portfolio)
      flash[:notice] = '"About Me" successfully updated'
    else
      flash[:alert] = helpers.display_errors(@about)
      render 'edit'
    end
  end

  private

  def confirm_owner
    unless current_user == @about.portfolio.user
      flash[:alert] = 'You are not the owner of that "About Me"'
      redirect_to root
    end
  end

  def set_new_record
    @about = @portfolio.about || About.new
  end

  def set_record
    @about = params[:id] ? About.find(params[:id]) : @about = About.new(about_params)
  end

  def about_params
    params.require(:about).permit(:about_me, :location, :about_me_brief,
                                  :github, :email, :linkedin, :facebook,
                                  :twitter, :website)
  end
end
