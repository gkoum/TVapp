require 'spec_helper'

describe "templates/new" do
  before(:each) do
    assign(:template, stub_model(Template,
      :name => "MyString",
      :description => "MyText",
      :number_of_areas => 1,
      :number_of_posts => 1
    ).as_new_record)
  end

  it "renders new template form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", templates_path, "post" do
      assert_select "input#template_name[name=?]", "template[name]"
      assert_select "textarea#template_description[name=?]", "template[description]"
      assert_select "input#template_number_of_areas[name=?]", "template[number_of_areas]"
      assert_select "input#template_number_of_posts[name=?]", "template[number_of_posts]"
    end
  end
end
