class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.integer :scene_id
      t.integer :number
      t.string :place
      t.string :dimension
      t.string :type

      t.timestamps
    end
  end
end
