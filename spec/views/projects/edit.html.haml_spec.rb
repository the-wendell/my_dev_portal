require 'rails_helper'

RSpec.describe "projects/edit", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :references => "",
      :titl => "MyString",
      :link => "MyString",
      :descrption => "MyText",
      :image => "MyString",
      :tech => "MyText",
      :role => "MyString"
    ))
  end

  it "renders the edit project form" do
    render

    assert_select "form[action=?][method=?]", project_path(@project), "post" do

      assert_select "input[name=?]", "project[references]"

      assert_select "input[name=?]", "project[titl]"

      assert_select "input[name=?]", "project[link]"

      assert_select "textarea[name=?]", "project[descrption]"

      assert_select "input[name=?]", "project[image]"

      assert_select "textarea[name=?]", "project[tech]"

      assert_select "input[name=?]", "project[role]"
    end
  end
end
