class Dashboard::PortfoliosController < Dashboard::DashboardController
  skip_before_action :confirm_portfolio_owner, only: %i[create]
  before_action :set_portfolio, only: %i[new edit update]
  before_action :confirm_owner, only: %i[update]

  def new
  end

  def edit
  end

  def create
    new_params = default_params
    new_params[:url] = portfolio_params[:url]
    @portfolio = current_user.portfolios.new(new_params)
    if @portfolio.save
      flash[:notice] = 'New Portfolio Created'
      redirect_to user_dashboard_index_path(current_user)
    else
      flash[:alert] = helpers.display_errors(@portfolio)
      redirect_to new_user_portfolio_path(current_user)
    end
  end

  def update
    if @portfolio.update(portfolio_params)
      redirect_to edit_portfolio_path(@portfolio)
      flash[:notice] = 'Portfolio updated successfully'
    else
      flash[:alert] = helpers.display_errors(@portfolio)
      render 'edit'
    end
  end

  def destroy
    @portfolio.destroy
    redirect_to root_path
  end

  private

  def confirm_owner
    unless current_user == @portfolio.user
      flash[:alert] = 'You are not the owner of that or portfolio'
      redirect_to root
    end
  end

  def set_portfolio
    @portfolio = helpers.active_portfolio
    @portfolios = current_user.portfolios.all
    @themes = Themes.array
  end

  def portfolio_params
    params.require(:portfolio).permit(:url, :theme, :color_one, :color_two,
                                      :color_three, :color_four,
                                      :font_color_one, :font_color_two,
                                      :show_cover_image, :show_avatar_image,
                                      :show_years_exp, :show_proficiency)
  end

  def default_params
    { theme: 'default',
      color_one: '#0a0d72', color_two: '#83c9f4',
      color_three: '#2196f3', color_four: '#00a6fb',
      font_color_one: '#ffffff', font_color_two: '#ffffff',
      show_cover_image: false, show_avatar_image: true,
      show_years_exp: true, show_proficiency: true }
  end
end
