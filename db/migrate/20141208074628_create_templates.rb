class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.text :description
      t.integer :number_of_areas
      t.integer :number_of_posts

      t.timestamps
    end
  end
end
