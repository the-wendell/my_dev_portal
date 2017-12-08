require 'rails_helper'

RSpec.describe "projects/show", type: :view do
  before(:each) do
    @project = assign(:project, Project.create!(
      :references => "",
      :titl => "Titl",
      :link => "Link",
      :descrption => "MyText",
      :image => "Image",
      :tech => "MyText",
      :role => "Role"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Titl/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Image/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Role/)
  end
end
