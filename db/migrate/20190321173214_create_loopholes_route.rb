class CreateLoopholesRoute < ActiveRecord::Migration[5.2]
  def change
    create_table :loopholes_routes do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :loopholes_node_pair
    end

    create_table :loopholes_node_pairs do |t|
      t.string :start_node
      t.string :end_node
    end
  end
end
