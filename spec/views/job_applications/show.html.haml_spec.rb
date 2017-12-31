require 'rails_helper'

RSpec.describe "job_applications/show", type: :view do
  before(:each) do
    @job_application = assign(:job_application, JobApplication.create!(
      :company_name => "Company Name",
      :company_website => "Company Website",
      :job_location => "Job Location",
      :enthusiasm => "Enthusiasm",
      :job_title => "Job Title",
      :job_link => "Job Link",
      :referral => "Referral",
      :referral_type => "Referral Type",
      :status => "Status",
      :industry => "Industry",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Company Name/)
    expect(rendered).to match(/Company Website/)
    expect(rendered).to match(/Job Location/)
    expect(rendered).to match(/Enthusiasm/)
    expect(rendered).to match(/Job Title/)
    expect(rendered).to match(/Job Link/)
    expect(rendered).to match(/Referral/)
    expect(rendered).to match(/Referral Type/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Industry/)
    expect(rendered).to match(/MyText/)
  end
end
