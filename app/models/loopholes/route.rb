class Loopholes::Route < ApplicationRecord
  belongs_to :node_pair, class_name: 'Loopholes::NodePair', foreign_key: :loopholes_node_pair_id

  def self.process(input_string, node_pairs_index_by_id)
    routes_data = JSON.parse(input_string, symbolize_names: true)[:routes]

    routes_data.map do |data|
      new(
        route_id: data[:route_id],
        loopholes_node_pair_id: node_pairs_index_by_id[data[:node_pair_id].to_i].try(:id),
        start_time: Time.zone.parse(data[:start_time].to_s),
        end_time: Time.zone.parse(data[:end_time].to_s)
      )
    end
  end
end
