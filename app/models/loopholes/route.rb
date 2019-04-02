class Loopholes::Route < ApplicationRecord
  belongs_to :node_pair, class_name: 'Loopholes::NodePair', foreign_key: :loopholes_node_pair_id
end
