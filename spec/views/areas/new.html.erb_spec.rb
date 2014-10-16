require 'spec_helper'

describe "areas/new" do
  before(:each) do
    assign(:area, stub_model(Area,
      :scene_id => 1,
      :number => 1,
      :place => "MyString",
      :dimension => "MyString",
      :type => ""
    ).as_new_record)
  end

  it "renders new area form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", areas_path, "post" do
      assert_select "input#area_scene_id[name=?]", "area[scene_id]"
      assert_select "input#area_number[name=?]", "area[number]"
      assert_select "input#area_place[name=?]", "area[place]"
      assert_select "input#area_dimension[name=?]", "area[dimension]"
      assert_select "input#area_type[name=?]", "area[type]"
    end
  end
end
