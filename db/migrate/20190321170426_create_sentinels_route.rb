class CreateSentinelsRoute < ActiveRecord::Migration[5.2]
  def change
    create_table :sentinels_routes do |t|
      t.integer :route_id
      t.string :node
      t.integer :index
      t.datetime :time
    end
  end
end
