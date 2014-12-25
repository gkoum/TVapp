class AddTemplateIdToAreas < ActiveRecord::Migration
  def change
    add_column :areas, :template_id, :integer
  end
end
