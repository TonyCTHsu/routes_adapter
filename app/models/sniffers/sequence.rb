class Sniffers::Sequence < ApplicationRecord
  belongs_to :node_time, class_name: 'Sniffers::NodeTime'
  belongs_to :route, class_name: 'Sniffers::Route'
end
