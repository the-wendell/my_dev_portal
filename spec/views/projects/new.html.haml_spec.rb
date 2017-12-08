require 'rails_helper'

RSpec.describe "projects/new", type: :view do
  before(:each) do
    assign(:project, Project.new(
      :references => "",
      :titl => "MyString",
      :link => "MyString",
      :descrption => "MyText",
      :image => "MyString",
      :tech => "MyText",
      :role => "MyString"
    ))
  end

  it "renders new project form" do
    render

    assert_select "form[action=?][method=?]", projects_path, "post" do

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
