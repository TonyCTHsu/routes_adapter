module Sniffers
  class Route < ApplicationRecord
    has_many :sequences, class_name: 'Sniffers::Sequence', foreign_key: :sniffers_route_id
    has_many :node_times, through: :sequences, class_name: 'Sniffers::NodeTime'

    def self.process(string)
      formatted_string = InputStringHelper.format(string)

      CSV.parse(formatted_string, headers: true).map do |row|
        new(
          id: row['route_id'],
          time: Time.zone.parse(row['time'].to_s + row['time_zone'].to_s)
        )
      end
    end
  end
end
