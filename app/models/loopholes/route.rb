class Loopholes::Route < ApplicationRecord
  belongs_to :node_pair, class_name: 'Loopholes::NodePair'
end
