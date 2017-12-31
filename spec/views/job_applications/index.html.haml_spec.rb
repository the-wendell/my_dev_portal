require 'rails_helper'

RSpec.describe "job_applications/index", type: :view do
  before(:each) do
    assign(:job_applications, [
      JobApplication.create!(
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
      ),
      JobApplication.create!(
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
      )
    ])
  end

  it "renders a list of job_applications" do
    render
    assert_select "tr>td", :text => "Company Name".to_s, :count => 2
    assert_select "tr>td", :text => "Company Website".to_s, :count => 2
    assert_select "tr>td", :text => "Job Location".to_s, :count => 2
    assert_select "tr>td", :text => "Enthusiasm".to_s, :count => 2
    assert_select "tr>td", :text => "Job Title".to_s, :count => 2
    assert_select "tr>td", :text => "Job Link".to_s, :count => 2
    assert_select "tr>td", :text => "Referral".to_s, :count => 2
    assert_select "tr>td", :text => "Referral Type".to_s, :count => 2
    assert_select "tr>td", :text => "Status".to_s, :count => 2
    assert_select "tr>td", :text => "Industry".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
