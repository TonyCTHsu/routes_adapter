class Sniffers::Route < ApplicationRecord
  has_many :sequences, class_name: 'Sniffers::Sequence', foreign_key: :sniffers_route_id
  has_many :node_times, through: :sequences, class_name: 'Sniffers::NodeTime'

  def self.process(input_string)
    string = input_string.encode('ascii-8bit').force_encoding('utf-8').tr('\"', '').gsub(', ', ',')

    CSV.parse(string, headers: true).map do |row|
      new(
        id: row['route_id'],
        time: Time.zone.parse(row['time'].to_s + row['time_zone'].to_s)
      )
    end
  end
end
