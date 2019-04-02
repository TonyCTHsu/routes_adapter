class CreateSniffersRoute < ActiveRecord::Migration[5.2]
  def change
    create_table :sniffers_routes do |t|
      t.datetime :time
    end

    create_table :sniffers_node_times do |t|
      t.string :start_node
      t.string :end_node
      t.integer :duration
    end

    create_join_table :sniffers_routes, :sniffers_node_times, table_name: :sniffers_sequences, primary_key: [:sniffers_route_id, :sniffers_node_time_id] do |t|
      t.index :sniffers_node_time_id
      t.index :sniffers_route_id
    end
  end
end
