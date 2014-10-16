class AddSceneIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :scene_id, :integer
    add_column :microposts, :area_id, :integer
  end
end
