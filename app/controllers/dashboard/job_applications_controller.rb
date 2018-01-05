class Dashboard::JobApplicationsController < Dashboard::DashboardController
  before_action :set_job_application, only: %i[show edit update destroy]
  before_action :combine_params, only: %i[index]

  def index

    @filterrific = initialize_filterrific(
      JobApplication,
      @filter_params,
      select_options: {
        sorted_by: JobApplication.options_for_sorted_by,
        asc_desc: JobApplication.options_for_asc_desc
      },
      available_filters: %i[sorted_by]
    ) || return
    @job_applications = current_user.job_applications.filterrific_find(@filterrific)

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) && return
  end

  def show
  end

  def new
    @job_application = JobApplication.new
  end

  def edit
  end

  def create
    @job_applications = current_user.job_applications.all
    @job_application = JobApplication.new(job_application_params)
    @job_application.user = current_user

    if @job_application.save
      redirect_to user_job_applications_path(current_user)
      flash[:notice] = 'Job Application successfully created!'
    else
      flash[:alert] = helpers.display_errors(@job_application)
      render 'index'
    end
  end

  def update
    if @job_application.update(job_application_params)
      redirect_to user_job_applications_path(current_user)
      flash[:notice] = 'Job Application successfully created!'
    else
      flash[:alert] = helpers.display_errors(@job_application)
      render 'index'
    end
  end

  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to user_job_applications_path(current_user), notice: 'Job application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def combine_params
      @filter_params = params[:filterrific]
      
      if @filter_params
        @filter_params[:sorted_by] << @filter_params[:asc_desc]
      end
    end

    def set_job_application
      @portfolio = current_user.portfolios.first
      @job_application = JobApplication.find(params[:id])
    end

    def job_application_params
      params.require(:job_application).permit(:first_contact_date, :company_name, :company_website, :job_location, :enthusiasm, :job_title, :job_link, :referral, :referral_type, :status, :industry, :notes)
    end
end
