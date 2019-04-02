class Sniffers::NodeTime < ApplicationRecord
  has_many :sequences, class_name: 'Sniffers::Sequence'
  has_many :routes, through: :sequences, class_name: 'Sniffers::Route'
end
