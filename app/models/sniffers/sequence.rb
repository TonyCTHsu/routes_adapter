module Sniffers
  class Sequence < ApplicationRecord
    belongs_to :node_time, class_name: 'Sniffers::NodeTime', foreign_key: :sniffers_node_time_id
    belongs_to :route, class_name: 'Sniffers::Route', foreign_key: :sniffers_route_id

    def self.process(string)
      formatted_string = InputStringHelper.format(string)

      CSV.parse(formatted_string, headers: true).map do |row|
        new(
          sniffers_route_id: row['route_id'],
          sniffers_node_time_id: row['node_time_id']
        )
      end
    end
  end
end
