module Loopholes
  class NodePair < ApplicationRecord
    has_many :routes, class_name: 'Loopholes::Route', foreign_key: :loopholes_node_pair_id

    def self.process(string)
      node_pairs_data = JSON.parse(string, symbolize_names: true)[:node_pairs]

      node_pairs_data.map do |data|
        new(data)
      end
    end
  end
end
