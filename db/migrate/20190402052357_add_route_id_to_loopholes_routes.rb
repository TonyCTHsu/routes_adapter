class AddRouteIdToLoopholesRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :loopholes_routes, :route_id, :bigint, null: false
    add_index :loopholes_routes, [:loopholes_node_pair_id, :route_id], unique: true
  end
end
