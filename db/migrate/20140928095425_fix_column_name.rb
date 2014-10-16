class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :scenes, :type, :scene_type
  end
end