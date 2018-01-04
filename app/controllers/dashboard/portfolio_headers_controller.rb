class Dashboard::PortfolioHeadersController < Dashboard::DashboardController
  before_action :set_record, only: %i[update edit create show]
  before_action :set_new_record, only: %i[index new]
  before_action :confirm_owner, only: %i[update]

  def index
    render @portfolio.portfolio_header ? 'edit' : 'new'
  end

  def show
    render 'edit'
  end

  def new
  end

  def edit
  end

  def create
    @portfolio_header.portfolio = @portfolio

    if @portfolio_header.save
      redirect_to portfolio_portfolio_headers_path(@portfolio)
      flash[:notice] = 'Portfolio Header successfully created!'
    else
      flash[:alert] = helpers.display_errors(@portfolio_header)
      render 'new'
    end
  end

  def update
    if @portfolio_header.update(portfolio_header_params)
      redirect_to portfolio_portfolio_headers_path(@portfolio)
      flash[:notice] = 'Portfolio Header successfully updated'
    else
      flash[:alert] = helpers.display_errors(@portfolio_header)
      render 'edit'
    end
  end

  private

  def confirm_owner
    unless current_user == @portfolio_header.portfolio.user
      flash[:alert] = 'You are not the owner of that portfolio'
      redirect_to root
    end
  end

  def set_new_record
    @portfolio_header = @portfolio.portfolio_header || PortfolioHeader.new
  end

  def set_record
    @portfolio_header = params[:id] ? PortfolioHeader.find(params[:id]) : PortfolioHeader.new(portfolio_header_params)
  end

  def portfolio_header_params
    params.require(:portfolio_header).permit(:header_one, :header_two,
                                    :cover_image, :avatar_image,
                                    :header_one_color, :header_two_color)
  end
end
