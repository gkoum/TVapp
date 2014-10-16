require 'spec_helper'

describe "areas/show" do
  before(:each) do
    @area = assign(:area, stub_model(Area,
      :scene_id => 1,
      :number => 2,
      :place => "Place",
      :dimension => "Dimension",
      :type => "Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/Place/)
    rendered.should match(/Dimension/)
    rendered.should match(/Type/)
  end
end
