require 'spec_helper'

describe "areas/index" do
  before(:each) do
    assign(:areas, [
      stub_model(Area,
        :scene_id => 1,
        :number => 2,
        :place => "Place",
        :dimension => "Dimension",
        :type => "Type"
      ),
      stub_model(Area,
        :scene_id => 1,
        :number => 2,
        :place => "Place",
        :dimension => "Dimension",
        :type => "Type"
      )
    ])
  end

  it "renders a list of areas" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Place".to_s, :count => 2
    assert_select "tr>td", :text => "Dimension".to_s, :count => 2
    assert_select "tr>td", :text => "Type".to_s, :count => 2
  end
end
