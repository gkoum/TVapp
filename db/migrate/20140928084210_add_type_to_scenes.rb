class AddTypeToScenes < ActiveRecord::Migration
  def change
    add_column :scenes, :type, :integer
  end
end
