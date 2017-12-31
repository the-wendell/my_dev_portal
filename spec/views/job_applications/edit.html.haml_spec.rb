require 'rails_helper'

RSpec.describe "job_applications/edit", type: :view do
  before(:each) do
    @job_application = assign(:job_application, JobApplication.create!(
      :company_name => "MyString",
      :company_website => "MyString",
      :job_location => "MyString",
      :enthusiasm => "MyString",
      :job_title => "MyString",
      :job_link => "MyString",
      :referral => "MyString",
      :referral_type => "MyString",
      :status => "MyString",
      :industry => "MyString",
      :notes => "MyText"
    ))
  end

  it "renders the edit job_application form" do
    render

    assert_select "form[action=?][method=?]", job_application_path(@job_application), "post" do

      assert_select "input[name=?]", "job_application[company_name]"

      assert_select "input[name=?]", "job_application[company_website]"

      assert_select "input[name=?]", "job_application[job_location]"

      assert_select "input[name=?]", "job_application[enthusiasm]"

      assert_select "input[name=?]", "job_application[job_title]"

      assert_select "input[name=?]", "job_application[job_link]"

      assert_select "input[name=?]", "job_application[referral]"

      assert_select "input[name=?]", "job_application[referral_type]"

      assert_select "input[name=?]", "job_application[status]"

      assert_select "input[name=?]", "job_application[industry]"

      assert_select "textarea[name=?]", "job_application[notes]"
    end
  end
end
