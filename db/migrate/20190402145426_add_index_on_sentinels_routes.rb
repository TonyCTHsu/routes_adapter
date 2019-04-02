class AddIndexOnSentinelsRoutes < ActiveRecord::Migration[5.2]
  def change
    add_index :sentinels_routes, [:route_id, :index], unique: true
  end
end
