require 'rails_helper'

RSpec.describe "projects/index", type: :view do
  before(:each) do
    assign(:projects, [
      Project.create!(
        :references => "",
        :titl => "Titl",
        :link => "Link",
        :descrption => "MyText",
        :image => "Image",
        :tech => "MyText",
        :role => "Role"
      ),
      Project.create!(
        :references => "",
        :titl => "Titl",
        :link => "Link",
        :descrption => "MyText",
        :image => "Image",
        :tech => "MyText",
        :role => "Role"
      )
    ])
  end

  it "renders a list of projects" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Titl".to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Role".to_s, :count => 2
  end
end
