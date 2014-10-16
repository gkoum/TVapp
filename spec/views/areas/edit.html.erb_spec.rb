require 'spec_helper'

describe "areas/edit" do
  before(:each) do
    @area = assign(:area, stub_model(Area,
      :scene_id => 1,
      :number => 1,
      :place => "MyString",
      :dimension => "MyString",
      :type => ""
    ))
  end

  it "renders the edit area form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", area_path(@area), "post" do
      assert_select "input#area_scene_id[name=?]", "area[scene_id]"
      assert_select "input#area_number[name=?]", "area[number]"
      assert_select "input#area_place[name=?]", "area[place]"
      assert_select "input#area_dimension[name=?]", "area[dimension]"
      assert_select "input#area_type[name=?]", "area[type]"
    end
  end
end
