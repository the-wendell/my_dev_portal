class JobApplicationsController < ApplicationController
  layout 'dashboard'
  before_action :set_job_application, only: [:show, :edit, :update, :destroy]

  # GET /job_applications
  # GET /job_applications.json
  def index
    # TODO: Set up global variable for portfolio
    @portfolio = current_user.portfolios.first
    @job_applications = current_user.job_applications.all
  end

  # GET /job_applications/1
  # GET /job_applications/1.json
  def show
  end

  # GET /job_applications/new
  def new
    @portfolio = current_user.portfolios.first
    @job_application = JobApplication.new
  end

  # GET /job_applications/1/edit
  def edit
  end

  # POST /job_applications
  # POST /job_applications.json
  def create
    @portfolio = current_user.portfolios.first
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

  # PATCH/PUT /job_applications/1
  # PATCH/PUT /job_applications/1.json
  def update
    respond_to do |format|
      if @job_application.update(job_application_params)
        format.html { redirect_to @job_application, notice: 'Job application was successfully updated.' }
        format.json { render :show, status: :ok, location: @job_application }
      else
        format.html { render :edit }
        format.json { render json: @job_application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /job_applications/1
  # DELETE /job_applications/1.json
  def destroy
    @job_application.destroy
    respond_to do |format|
      format.html { redirect_to user_job_applications_path(current_user), notice: 'Job application was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job_application
      @job_application = JobApplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_application_params
      params.require(:job_application).permit(:first_contact_date, :company_name, :company_website, :job_location, :enthusiasm, :job_title, :job_link, :referral, :referral_type, :status, :industry, :notes)
    end
end
