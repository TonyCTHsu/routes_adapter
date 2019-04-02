class Sniffers::Sequence < ApplicationRecord
  belongs_to :node_time, class_name: 'Sniffers::NodeTime', foreign_key: :sniffers_node_time_id
  belongs_to :route, class_name: 'Sniffers::Route', foreign_key: :sniffers_route_id
end
