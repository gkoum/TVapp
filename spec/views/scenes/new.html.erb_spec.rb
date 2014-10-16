require 'spec_helper'

describe "scenes/new" do
  before(:each) do
    assign(:scene, stub_model(Scene,
      :name => "MyString",
      :url => "MyString"
    ).as_new_record)
  end

  it "renders new scene form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", scenes_path, "post" do
      assert_select "input#scene_name[name=?]", "scene[name]"
      assert_select "input#scene_url[name=?]", "scene[url]"
    end
  end
end
