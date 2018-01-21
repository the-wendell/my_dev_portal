class Dashboard::JobApplicationsController < Dashboard::DashboardController
  require 'csv'
  before_action :set_job_application, only: %i[show edit update destroy]
  before_action :combine_params, only: %i[index]
  before_action :set_dashboard

  def index
    @filterrific = initialize_filterrific(
      JobApplication,
      @filter_params,
      select_options: {
        sorted_by: JobApplication.options_for_sorted_by,
        asc_desc: JobApplication.options_for_asc_desc,
        enthusiasm: JobApplication.options_for_enthusiasm,
        referral_type: JobApplication.options_for_referral_type,
        status: JobApplication.options_for_status
      },
      available_filters: %i[sorted_by search_query enthusiasm referral_type status time_period]
    ) || return
    @job_applications = current_user.job_applications.filterrific_find(@filterrific)

    rescue ActiveRecord::RecordNotFound => e
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) && return

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"job-applications-#{Date.today}\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
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
    redirect_to user_job_applications_path(current_user), notice: 'Job application was successfully destroyed.'
  end

  private

    def set_dashboard
      @dashboard = 'job_applications'
    end

    def combine_params
      @filter_params = params[:filterrific]

      if @filter_params
        @filter_params[:sorted_by] << @filter_params[:asc_desc] rescue 'asc'
        @filter_params[:time_period] = before_and_after
      end
    end

    def before_and_after
      fp = @filter_params
      before = "#{fp['before(1i)']}-#{fp['before(2i)']}-#{fp['before(3i)']}"
      after = "#{fp['after(1i)']}-#{fp['after(2i)']}-#{fp['after(3i)']}"
      before_and_after = "#{before},#{after}"
    end

    def set_job_application
      @portfolio = current_user.portfolios.first
      @job_application = JobApplication.find(params[:id])
    end

    def job_application_params
      params.require(:job_application).permit(:first_contact_date, :company_name, :company_website, :job_location, :enthusiasm, :job_title, :job_link, :referral, :referral_type, :status, :industry, :notes)
    end
end
