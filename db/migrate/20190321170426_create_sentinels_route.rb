class CreateSentinelsRoute < ActiveRecord::Migration[5.2]
  def change
    create_table :sentinels_routes do |t|
      t.integer :route_id
      t.integer :node
      t.integer :index
      t.datetime :time
      t.timestamps
    end
  end
end
