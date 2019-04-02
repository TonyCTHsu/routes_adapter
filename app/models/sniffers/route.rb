class Sniffers::Route < ApplicationRecord
  has_many :sequences, class_name: 'Sniffers::Sequence'
  has_many :node_times, through: :sequences, class_name: 'Sniffers::NodeTime'
end
